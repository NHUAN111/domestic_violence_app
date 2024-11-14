import 'package:flutter/material.dart';
import 'package:project_domestic_violence/app/utils/color.dart';

class EmergencyButtonComponent extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const EmergencyButtonComponent({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: ColorData.colorIcon,
          ),
          SizedBox(width: 2),
          Text(label,
              style: TextStyle(fontSize: 14, color: ColorData.colorIcon)),
        ],
      ),
    );
  }
}
