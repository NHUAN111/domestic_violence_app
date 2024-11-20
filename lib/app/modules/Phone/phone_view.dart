import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/components/button_component.dart';
import 'package:project_domestic_violence/app/components/contact_component.dart';
import 'package:project_domestic_violence/app/data/localdata/datahelper_contact.dart';
import 'package:project_domestic_violence/app/models/contact.dart';
import 'package:project_domestic_violence/app/models/user.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'package:project_domestic_violence/app/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneView extends StatefulWidget {
  @override
  _PhoneViewState createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneView> {
  final DatabaseHelperContact _databaseService = DatabaseHelperContact();
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  // Load liên lạc
  void _loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(Constant.USER);
    UserModel user = UserModel.fromJson(jsonDecode(userJson!));

    print("user id ${user.accountId}");
    if (user.accountId != null) {
      List<Contact> contacts =
          await _databaseService.getAllContacts(user.accountId!);
      setState(() {
        _contacts = contacts;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('UserId không tồn tại. Vui lòng đăng nhập.')),
      );
    }
  }

  // Save contact
  void _saveContact(String userId, String name, String phoneNumber) async {
    if (name.isNotEmpty && phoneNumber.isNotEmpty) {
      Contact newContact = Contact(
        userId: userId.toString(),
        name: name.toString(),
        phoneNumber: phoneNumber.toString(),
      );

      await _databaseService.insertContact(newContact);

      _loadContacts();
      BaseToast.showSuccessToast("Success", "Contact save successfully");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Vui lòng nhập đầy đủ thông tin!'),
      ));
    }
  }

  // Thực hiện cuộc gọi
  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Modal giao diện
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
                    String? userJson = prefs.getString(Constant.USER);
                    UserModel user = UserModel.fromJson(jsonDecode(userJson!));
                    _saveContact(user.accountId!, nameController.text,
                        phoneController.text);
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

  // Main
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorData.colorNavBar,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.contacts,
              color: ColorData.colorIcon,
              size: 30,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 26,
                    color: ColorData.colorIcon,
                  ),
                  onPressed: () {
                    // Thêm
                    _showAddContactModal(context);
                  },
                ),
                Text(
                  'Add contact',
                  style: TextStyle(
                    color: ColorData.colorIcon,
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
            child: _contacts.isEmpty
                ? Center(
                    child: Text(
                      'No contacts available',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _contacts.length,
                    itemBuilder: (context, index) {
                      Contact contact = _contacts[index];

                      // Check if contact is null or has no name/phone number
                      if (contact == null ||
                          contact.name == null ||
                          contact.phoneNumber == null) {
                        return ListTile(
                          title: Text('Contact information is not available'),
                        );
                      }

                      return ContactComponent(
                        nameContact: contact.name.toString(),
                        onPresseDetail: () {
                          print('detail');
                          Get.toNamed(Routes.detaiPhone, arguments: contact)
                              ?.then((value) {
                            _loadContacts();
                          });
                        },
                        onPresseCall: () {
                          print('call');
                          // _makePhoneCall(contact.phoneNumber ?? '');
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
