import 'package:flutter/material.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final Function onClick;
  final Color color;
  final bool underline;
  const ClickableText({
    super.key,
    required this.text,
    required this.onClick,
    this.color = Colors.white,
    this.underline = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: SwitchTexts.linkDefault(
          color,
          underline,
        ),
      ),
    );
  }
}
