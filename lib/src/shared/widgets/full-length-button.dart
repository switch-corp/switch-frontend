import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class FullLengthButton extends StatelessWidget {
  final String text;
  final Function onClick;
  const FullLengthButton({
    super.key,
    required this.text,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: SwitchColors.ui_blueziness_800,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 12, top: 12),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: SwitchTexts.fullLenghtButtonText(),
          ),
        ),
      ),
    );
  }
}
