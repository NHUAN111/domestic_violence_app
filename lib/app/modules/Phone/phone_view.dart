import 'package:flutter/material.dart';
import 'package:project_domestic_violence/app/components/ButtonComponent.dart';
import 'package:project_domestic_violence/app/components/ContactComponent.dart';
import 'package:project_domestic_violence/app/data/localdata/LocalStorageService.dart';
import 'package:project_domestic_violence/app/models/contact.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneView extends StatefulWidget {
  @override
  _PhoneViewState createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  final DatabaseHelperContact _databaseService = DatabaseHelperContact();
  List<Contact> _contacts = [];
  String? _selectedPhoneNumber;

  @override
  void initState() {
    super.initState();
    _loadContacts();
    _loadSelectedPhoneNumber();
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  void _loadContacts() async {
    String? userId = await getUserId();
    if (userId != null) {
      List<Contact> contacts = await _databaseService.getAllContacts(userId);
      setState(() {
        _contacts = contacts;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('UserId không tồn tại. Vui lòng đăng nhập.')),
      );
    }
  }

  void _loadSelectedPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedPhoneNumber = prefs.getString('selectedPhoneNumber');
    });
  }

  void _saveSelectedPhoneNumber(String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedPhoneNumber', phoneNumber);
  }

  void _saveContact(String userId, String name, String phoneNumber) async {
    if (name.isNotEmpty && phoneNumber.isNotEmpty) {
      Contact newContact = Contact(
        userId: userId.toString(),
        name: name.toString(),
        phoneNumber: phoneNumber.toString(),
      );

      await _databaseService.insertContact(newContact);

      _loadContacts();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Vui lòng nhập đầy đủ thông tin!'),
      ));
    }
  }

  // Xóa danh bạ
  // void _deleteContact(Contact contact) async {
  //   await _databaseService.deleteContact(contact.contactId); // Xóa khỏi SQLite

  //   setState(() {
  //     _contacts.remove(contact);
  //   });
  // }

  // Thực hiện cuộc gọi
  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showAddContactModal(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'More Contact Info',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: ColorData.colorText,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Container(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Contact Name'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone number'),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonComponent(
                  text: 'Cancel',
                  onPress: () {
                    //
                    Navigator.of(context).pop();
                  },
                  backgroundColor: ColorData.colorNavBar,
                  textColor: ColorData.colorText,
                ),
                ButtonComponent(
                  text: 'Add',
                  onPress: () async {
                    final prefs = await SharedPreferences.getInstance();
                    _saveContact(prefs.getString('userId').toString(),
                        nameController.text, phoneController.text);
                    Navigator.of(context).pop();
                  },
                  backgroundColor: ColorData.colorMain,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorData.colorNavBar,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // IconButton(
            //   icon: Icon(
            //     Icons.arrow_back_ios,
            //     size: 22,
            //     color: ColorData.colorIcon,
            //   ),
            //   onPressed: () {},
            // ),
            Image.asset(
              'assets/images/icontym.png',
              width: 50,
              height: 50,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 26,
                    color: ColorData.colortextSecond,
                  ),
                  onPressed: () {
                    // Thêm
                    _showAddContactModal(context);
                  },
                ),
                Text(
                  'Add contact',
                  style: TextStyle(
                    color: ColorData.colortextSecond,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                Contact contact = _contacts[index];
                return ContactComponent(
                  nameContact: contact.name.toString(),
                  onPresseDelete: () {
                    //
                  },
                  onPresseCall: () {
                    _makePhoneCall(contact.phoneNumber ?? '');
                  },
                  phoneContact: contact.phoneNumber.toString(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
