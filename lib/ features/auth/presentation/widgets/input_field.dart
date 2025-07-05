import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final double fontSize;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final bool obscureText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  const InputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.fontSize,
    required this.borderRadius,
    required this.padding,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: borderRadius,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: FaIcon(icon, color: Colors.grey[700], size: fontSize + 2),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              onChanged: onChanged,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: fontSize, color: Colors.grey[600]),
                contentPadding: padding,
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 