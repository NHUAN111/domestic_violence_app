import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/localdata/datahelper_contact.dart';
import 'package:project_domestic_violence/app/models/contact.dart';
import 'package:project_domestic_violence/app/models/user.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SMSConfig extends StatefulWidget {
  const SMSConfig({Key? key}) : super(key: key);

  @override
  _SMSConfigState createState() => _SMSConfigState();
}

class _SMSConfigState extends State<SMSConfig> {
  final DatabaseHelperContact _databaseService = DatabaseHelperContact();
  List<Contact> _contacts = [];
  List<bool> _selectedContacts = []; // Danh sách trạng thái select
  bool selectAll = false; // Trạng thái Select All

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(Constant.USER);
    if (userJson != null) {
      UserModel user = UserModel.fromJson(jsonDecode(userJson));
      if (user.accountId != null) {
        List<Contact> contacts =
            await _databaseService.getAllContacts(user.accountId!);
        setState(() {
          _contacts = contacts;
          _selectedContacts = List.generate(_contacts.length, (_) => false);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('UserId không tồn tại. Vui lòng đăng nhập.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không tìm thấy thông tin người dùng.')),
      );
    }
  }

  void _toggleSelectAll(bool value) {
    setState(() {
      selectAll = value;
      _selectedContacts = List.generate(_contacts.length, (_) => value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configure SOS messages",
          style: TextStyle(
            color: ColorData.colorIcon,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Search contact',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.mic),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 2,
                color: Color.fromARGB(255, 255, 230, 230),
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.smsaddtitle);
                          },
                          child: Text(
                            "Click here to select or add a message to send",
                            style: TextStyle(
                              fontSize: 18,
                              color: ColorData.colorSos,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.sms,
                        color: ColorData.colorSos,
                        size: 34,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: selectAll,
                    onChanged: (value) {
                      _toggleSelectAll(value ?? false);
                    },
                  ),
                  Text("Select All"),
                ],
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 900,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) {
                    return SOSMessageCard(
                      contact: _contacts[index],
                      isSelected: _selectedContacts[index],
                      onSelected: (value) {
                        setState(() {
                          _selectedContacts[index] = value;
                          selectAll = _selectedContacts.every((e) => e);
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SOSMessageCard extends StatelessWidget {
  final Contact contact;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const SOSMessageCard({
    required this.contact,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 400,
          width: 200,
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/sosicon.png",
                height: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                contact.name ?? "No Name",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
          top: -6,
          right: -2,
          child: Checkbox(
            value: isSelected,
            onChanged: (value) {
              onSelected;
            },
          ),
        ),
      ],
    );
  }
}
