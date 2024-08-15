import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:switchfrontend/src/features/home/widgets/custom_actions_button.dart';
import 'package:switchfrontend/src/features/home/widgets/cutom_menu_item_button.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: SwitchColors.steel_gray_950,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 36,
                      height: 36,
                    ),
                    Image(
                      width: 36,
                      height: 36,
                      image: NetworkImage(
                          "https://i.pinimg.com/564x/40/a4/2f/40a42f4b27a14089b82a916aaff0b298.jpg"),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 28, 0, 32),
                  child: Row(
                    children: [
                      Text(
                        'Home',
                        style: SwitchTexts.titleScreen(
                            SwitchColors.steel_gray_100),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomMenuItemButton(label: 'rooms'),
                            CustomMenuItemButton(label: 'switches'),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomMenuItemButton(label: 'auto'),
                            CustomMenuItemButton(label: 'config'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 28, 0, 32),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Actions',
                            style: SwitchTexts.titleScreen(
                                SwitchColors.steel_gray_100),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomActionButton(
                        label: 'Do this',
                        url:
                            "https://i.pinimg.com/564x/40/a4/2f/40a42f4b27a14089b82a916aaff0b298.jpg",
                      ),
                      CustomActionButton(
                        label: 'Do this',
                        url:
                            "https://i.pinimg.com/564x/40/a4/2f/40a42f4b27a14089b82a916aaff0b298.jpg",
                      ),
                      CustomActionButton(
                        label: 'Do this',
                        url:
                            "https://i.pinimg.com/564x/40/a4/2f/40a42f4b27a14089b82a916aaff0b298.jpg",
                      ),
                      CustomActionButton(
                        label: 'Do this',
                        url:
                            "https://i.pinimg.com/564x/40/a4/2f/40a42f4b27a14089b82a916aaff0b298.jpg",
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'próximo evento em',
                            style: SwitchTexts.titleGroup(
                                SwitchColors.steel_gray_400),
                          ),
                          Text(
                            '30:34 min',
                            style: SwitchTexts.titleSection(
                                SwitchColors.steel_gray_200),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                            color: SwitchColors.steel_gray_600,
                          ),
                        ),
                        width: 115,
                        // (MediaQuery.of(context).size.width / 2) - (2 * 12),
                        height: 102,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image(
                                  width: 24,
                                  height: 24,
                                  image: NetworkImage(
                                      "https://i.pinimg.com/564x/40/a4/2f/40a42f4b27a14089b82a916aaff0b298.jpg"),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Text(
                                'Open cafe',
                                style: SwitchTexts.bodyDefaultBold(
                                    SwitchColors.steel_gray_100),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
