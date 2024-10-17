import 'package:flutter/material.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class ButtonComponent extends StatefulWidget {
  final String text;
  final VoidCallback onPress;
  final Color textColor;
  final Color backgroundColor;

  const ButtonComponent({
    Key? key,
    required this.text,
    required this.onPress,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
    );
  }
}
