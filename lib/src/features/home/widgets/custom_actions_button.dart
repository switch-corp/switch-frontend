import 'package:flutter/material.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';

import '../../../shared/enums/switch_texts.dart';

class CustomActionButton extends StatelessWidget {
  final String label;
  final String url;

  CustomActionButton({super.key, required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: SwitchColors.steel_gray_600,
            ),
          ),
          width: 115,
          // (MediaQuery.of(context).size.width / 2) - (2 * 12),
          height: 102,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image(
                    width: 24,
                    height: 24,
                    image: NetworkImage(this.url),
                  ),
                ],
              ),
              Flexible(
                child: Text(
                  this.label,
                  style:
                      SwitchTexts.bodyDefaultBold(SwitchColors.steel_gray_100),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }
}
