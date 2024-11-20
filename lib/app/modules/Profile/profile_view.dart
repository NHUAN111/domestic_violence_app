import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/components/profile_card_component.dart';
import 'package:project_domestic_violence/app/models/user.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/color.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'package:project_domestic_violence/app/utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late String name;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = prefs.getString(Constant.USER) ?? '';
    if (userJson.isNotEmpty) {
      UserModel user = UserModel.fromJson(jsonDecode(userJson));
      name = user.userName ?? '';
    }
  }

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
                  'Hello ${name}',
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
              icon: Icon(
                Icons.account_box_rounded,
                color: ColorData.colorIcon,
              ),
              onPress: () {
                Get.toNamed(Routes.profileDetail);
              },
              nameFuction: 'Personal Page',
            ),
            ProfileCardComponent(
              icon: Icon(
                Icons.history_outlined,
                color: ColorData.colorIcon,
              ),
              onPress: () {
                //
              },
              nameFuction: 'My Journal',
            ),
            ProfileCardComponent(
              icon: Icon(
                Icons.map,
                color: ColorData.colorIcon,
              ),
              onPress: () {
                Get.toNamed(Routes.safeplacesview);
              },
              nameFuction: 'Safe Places',
            ),
            ProfileCardComponent(
              icon: Icon(
                Icons.sms,
                color: ColorData.colorIcon,
              ),
              onPress: () {
                Get.toNamed(Routes.smsconfig);
              },
              nameFuction: 'Emergency Contact Config',
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
              icon: Icon(
                Icons.logout_rounded,
                color: ColorData.colorIcon,
              ),
              onPress: () {
                // Action for Log Out
                BaseToast.showConfirmToast(
                  "Notification",
                  "Are you sure logout ?",
                  () {
                    clearUserData();
                  },
                );
              },
              nameFuction: 'Log Out',
            ),
          ],
        ),
      ),
    );
  }
}

void clearUserData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(Constant.USER);
  BaseToast.showSuccessToast("Success", "Logout successful");
  Get.offAllNamed(Routes.signin);
}
