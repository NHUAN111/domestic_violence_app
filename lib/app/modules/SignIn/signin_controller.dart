import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/repository/authRepository.dart';
import 'package:project_domestic_violence/app/models/user.dart';
import 'package:project_domestic_violence/app/routes/app_pages.dart';
import 'package:project_domestic_violence/app/utils/constant.dart';
import 'package:project_domestic_violence/app/utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  late AuthRepository authRepository;
  SignInController(this.authRepository);

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isFormValid = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  void clearText() {
    emailController.clear();
    passwordController.clear();
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email không được để trống";
    } else if (!GetUtils.isEmail(value)) {
      return "Email không hợp lệ";
    }
    return null;
  }

  String? validatePass(String value) {
    if (value.isEmpty) {
      return "Mật khẩu không được để trống";
    }
    return null;
  }

  void validateAndSignin({required String email, required String pass}) async {
    if (formkey.currentState?.validate() ?? false) {
      try {
        UserModel user = await authRepository.signin(email, pass);

        final prefs = await SharedPreferences.getInstance();
        String userJson = jsonEncode(user.toJson());
        await prefs.setString(Constant.USER, userJson);

        BaseToast.showSuccessToast("Thành Công", "Đăng nhập thành công");
        Get.toNamed(Routes.home);

        clearText();
      } catch (e) {
        BaseToast.showErrorToast("Thất Bại", "Đăng nhập thất bại");
        print(e.toString());
      }
    } else {
      BaseToast.showWarningToast(
          "Lỗi", "Vui lòng điền đầy đủ và đúng thông tin");
    }
  }
}
