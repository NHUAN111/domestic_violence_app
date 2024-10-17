import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/data/repository/authRepository.dart';
import 'package:project_domestic_violence/app/utils/toast.dart';

class SignUpController extends GetxController {
  late AuthRepository authRepository;
  SignUpController(this.authRepository);

  // Form key
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // Controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Form validation
  bool isFormValid = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void clearText() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Tên không được để trống";
    }
    return null;
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

  void validateAndSignup({
    required String name,
    required String email,
    required String pass,
  }) async {
    if (formkey.currentState?.validate() ?? false) {
      try {
        await authRepository.signup({
          "userId": ID.unique(),
          "name": name,
          "email": email,
          "password": pass
        }).then((value) {
          BaseToast.showSuccessToast("Thành Công", "Đăng ký thành công");
          clearText();
        });
      } catch (e) {
        BaseToast.showErrorToast("Thất Bại", "Đăng ký thất bại");
        e.printError();
      }
    } else {
      BaseToast.showWarningToast(
          "Lỗi", "Vui lòng điền đầy đủ và đúng thông tin");
    }
  }
}
