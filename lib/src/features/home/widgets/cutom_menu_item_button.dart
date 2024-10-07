import 'package:flutter/material.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class CustomMenuItemButton extends StatelessWidget {
  final String label;

  const CustomMenuItemButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: SwitchColors.steel_gray_600,
        ),
      ),
      width: (MediaQuery.of(context).size.width / 2) - (2 * 12),
      height: 128,
      child: Text(
        label,
        style: SwitchTexts.titleBody(SwitchColors.steel_gray_100),
      ),
    );
  }
}
