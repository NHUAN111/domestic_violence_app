import 'package:flutter/material.dart';

class ButtonComponent extends StatefulWidget {
  final String text;
  final VoidCallback onPress;
  final Color textColor;
  final Color backgroundColor;
  final double? width; // Thêm chiều dài không bắt buộc

  const ButtonComponent({
    Key? key,
    required this.text,
    required this.onPress,
    required this.backgroundColor,
    required this.textColor,
    this.width, // Khởi tạo chiều dài không bắt buộc
  }) : super(key: key);

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget
          .width, // Nếu width không có giá trị, nó sẽ tự động lấy kích thước theo nội dung
      child: ElevatedButton(
        onPressed: widget.onPress,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: widget.backgroundColor, // Sử dụng màu từ tham số
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 16,
            color: widget.textColor,
          ),
        ),
      ),
    );
  }
}
