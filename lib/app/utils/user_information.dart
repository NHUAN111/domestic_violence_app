import 'dart:convert';

import 'package:project_domestic_violence/app/models/user.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfor {
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(Constant.USER);

    if (userJson != null && userJson.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}
