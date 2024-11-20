import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_domestic_violence/app/components/button_component.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class BaseToast {
  static void showSuccessToast(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor:
          Colors.green.withOpacity(0.8), // Màu nền (xanh cho thành công)
      colorText: Colors.white, // Màu chữ
      icon: Icon(Icons.check_circle, color: Colors.white), // Icon thông báo
      duration: Duration(seconds: 3), // Thời gian hiện thông báo
    );
  }

  static void showErrorToast(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor:
          Colors.red.withOpacity(0.8), // Màu nền đỏ cho thông báo lỗi
      colorText: Colors.white,
      icon: Icon(Icons.error, color: Colors.white),
      duration: Duration(seconds: 3),
    );
  }

  static void showWarningToast(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor:
          Colors.orange.withOpacity(0.8), // Màu nền cam cho cảnh báo
      colorText: Colors.white,
      icon: Icon(Icons.warning, color: Colors.white),
      duration: Duration(seconds: 3),
    );
  }

  static void showConfirmToast(
      String title, String message, final VoidCallback onPresse) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor:
          Colors.blue.withOpacity(0.8), // Màu nền xanh cho xác nhận
      colorText: Colors.white,
      icon: Icon(Icons.info, color: Colors.white), // Icon cho xác nhận
      duration: Duration(seconds: 3),
      mainButton: TextButton(
        onPressed: () {
          onPresse();
        },
        child: Text('Confirm ', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  static void showLoadingToast({String message = 'Loading...'}) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent, // Nền trong suốt
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(), // Vòng xoay loading
            SizedBox(height: 15),
            Text(
              message, // Thông báo đang tải
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      barrierDismissible: false, // Không cho phép đóng khi nhấn ngoài dialog
    );
  }

  static void hideLoadingToast() {
    if (Get.isDialogOpen ?? false) {
      Get.back(); // Đóng dialog
    }
  }

  static void showDialogCallPolice(BuildContext context,
      final VoidCallback onPresse, String title, String desc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(
            Icons.help,
            size: 40,
            color: ColorData.colorSos,
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorData.colorSos,
              fontSize: 20,
            ),
          ),
          content: Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            Center(
              child: ButtonComponent(
                text: "Confirm",
                onPress: () {
                  Navigator.of(context).pop(); // Đóng dialog
                  onPresse();
                },
                backgroundColor: ColorData.colorSos,
                textColor: Colors.white,
                width: 250,
              ),
            ),
          ],
        );
      },
    );
  }

  static void showDialogSendMess(
      BuildContext context, final VoidCallback onPresse) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Sending urgent message...',
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: ColorData.colorSos,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 50),
                ),
              ],
              totalRepeatCount: 20,
              displayFullTextOnTap: true,
            ),
          ),
          actions: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                'assets/images/sms.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
                onPresse();
              },
              label: Text(
                "Go to configuration",
                style: TextStyle(color: ColorData.colorText),
              ),
              icon: Icon(Icons.navigate_next, color: ColorData.colorText),
            ),
          ],
        );
      },
    );
  }
}
