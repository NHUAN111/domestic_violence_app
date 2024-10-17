import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/components/ProfileCardComponent.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/lion.png',
                  width: 100,
                  height: 140,
                ),
                Text(
                  'Hello Nhuan',
                  style: const TextStyle(
                    fontSize: 18,
                    color: ColorData.colorText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              height: 20,
              indent: 5,
              endIndent: 5,
            ),
            ProfileCardComponent(
              icon: Icon(Icons.account_box_rounded),
              onPress: () {
                // Action for Personal Page
              },
              nameFuction: 'Personal Page',
            ),
            ProfileCardComponent(
              icon: Icon(Icons.edit),
              onPress: () {
                Get.toNamed(Routes.settingPhone);
              },
              nameFuction: 'Customize calls',
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              height: 20,
              indent: 5,
              endIndent: 5,
            ),
            const Spacer(),
            ProfileCardComponent(
              icon: Icon(Icons.logout_rounded),
              onPress: () {
                // Action for Log Out
              },
              nameFuction: 'Log Out',
            ),
          ],
        ),
      ),
    );
  }
}
