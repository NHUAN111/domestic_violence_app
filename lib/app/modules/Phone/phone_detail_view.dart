import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/components/button_component.dart';
import 'package:project_domestic_violence/app/data/localdata/LocalStorageService.dart';
import 'package:project_domestic_violence/app/models/contact.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/toast.dart';

class PhoneDetailView extends StatefulWidget {
  @override
  _PhoneDetailViewState createState() => _PhoneDetailViewState();
}

class _PhoneDetailViewState extends State<PhoneDetailView> {
  late Contact contact;
  final DatabaseHelperContact _dbHelper = DatabaseHelperContact();

  @override
  void initState() {
    super.initState();
    contact = Get.arguments as Contact;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: contact.name);
    final TextEditingController phoneController =
        TextEditingController(text: contact.phoneNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Contact",
          style: TextStyle(
            color: ColorData.colorIcon,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorData.colorNavBar,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/sosicon.png'),
            ),
            SizedBox(height: 16),

            // Tên liên lạc
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Contact Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Số điện thoại liên lạc
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonComponent(
                  text: 'Update',
                  onPress: () async {
                    contact.name = nameController.text;
                    contact.phoneNumber = phoneController.text;

                    await _dbHelper.updateContact(contact);

                    BaseToast.showSuccessToast(
                        "Success", "Contact updated successfully!");
                  },
                  backgroundColor: ColorData.colorMain,
                  textColor: Colors.white,
                ),
                ButtonComponent(
                  text: 'Delete',
                  onPress: () async {
                    BaseToast.showConfirmToast(
                      "Notifacation",
                      "Are you sure delete contact ?",
                      () async {
                        await _dbHelper.deleteContact(contact.contactId!);
                        BaseToast.showSuccessToast(
                            "Success", "Contact deleted successfully!");
                        Navigator.pop(context);
                      },
                    );
                  },
                  backgroundColor: ColorData.colorSos,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
