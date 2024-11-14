import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:project_domestic_violence/app/models/user.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';

class SplashService {
  void checkAuthentication(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String? userJson = prefs.getString(Constant.USER);

      if (userJson == null || userJson.isEmpty) {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, Routes.signin);
      } else {
        UserModel user = UserModel.fromJson(jsonDecode(userJson));

        print("ID ${user.accountId}");
        print("Name ${user.userName}");
        if (user.userName?.isEmpty ?? true) {
          await Future.delayed(const Duration(seconds: 3));
          Navigator.pushReplacementNamed(context, Routes.signin);
        } else {
          await Future.delayed(const Duration(seconds: 3));
          Navigator.pushReplacementNamed(context, Routes.home);
        }
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("Error: $error");
        print("StackTrace: $stackTrace");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $error'),
        ),
      );
    }
  }
}
