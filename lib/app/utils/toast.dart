import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseToast {
  static void showSuccessToast(String title, String message) {
    Get.snackbar(
      title, // Tiêu đề thông báo
      message, // Nội dung thông báo
      snackPosition: SnackPosition.TOP, // Vị trí của toast
      backgroundColor: Colors.green, // Màu nền (xanh cho thành công)
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
      backgroundColor: Colors.red, // Màu nền đỏ cho thông báo lỗi
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
      backgroundColor: Colors.orange, // Màu nền cam cho cảnh báo
      colorText: Colors.white,
      icon: Icon(Icons.warning, color: Colors.white),
      duration: Duration(seconds: 3),
    );
  }

  void showConfirmToast(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue, // Màu nền xanh cho xác nhận
      colorText: Colors.white,
      icon: Icon(Icons.info, color: Colors.white), // Icon cho xác nhận
      duration: Duration(seconds: 3),
      mainButton: TextButton(
        onPressed: () {
          // Xử lý khi người dùng xác nhận
        },
        child: Text('Xác nhận', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void showLoadingToast({String message = 'Đang tải...'}) {
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

  void hideLoadingToast() {
    if (Get.isDialogOpen ?? false) {
      Get.back(); // Đóng dialog
    }
  }
}
