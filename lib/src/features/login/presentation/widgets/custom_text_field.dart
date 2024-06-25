import 'package:flutter/material.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool mandatory;
  final bool obscureText;
  final TextInputType keyboardType;
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.mandatory = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(color: SwitchColors.steel_gray_100),
            ),
            if (mandatory)
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  '*',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}
