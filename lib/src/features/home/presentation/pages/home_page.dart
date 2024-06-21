import 'package:flutter/material.dart';
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
                  // color: Color.fromARGB(255, 255, 0, 0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                              width: (MediaQuery.of(context).size.width / 2) -
                                  (2 * 12),
                              height: 128,
                              child: Text(
                                'rooms',
                                style: SwitchTexts.titleBody(
                                    SwitchColors.steel_gray_100),
                              ),
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
                              width: (MediaQuery.of(context).size.width / 2) -
                                  (2 * 12),
                              height: 128,
                              child: Text(
                                'switches',
                                style: SwitchTexts.titleBody(
                                    SwitchColors.steel_gray_100),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                              width: (MediaQuery.of(context).size.width / 2) -
                                  (2 * 12),
                              height: 128,
                              child: Text(
                                'auto',
                                style: SwitchTexts.titleBody(
                                    SwitchColors.steel_gray_100),
                              ),
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
                              width: (MediaQuery.of(context).size.width / 2) -
                                  (2 * 12),
                              height: 128,
                              child: Text(
                                'config',
                                style: SwitchTexts.titleBody(
                                    SwitchColors.steel_gray_100),
                              ),
                            )
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
                      Text(
                        'Home',
                        style: SwitchTexts.titleScreen(
                            SwitchColors.steel_gray_100),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Image(
                            width: 36,
                            height: 36,
                            image: NetworkImage(
                                "https://i.pinimg.com/564x/40/a4/2f/40a42f4b27a14089b82a916aaff0b298.jpg"),
                          ),
                          Text(
                            'Open cafe',
                            style: SwitchTexts.bodyDefaultBold(
                                SwitchColors.steel_gray_100),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Image(
                            width: 36,
                            height: 36,
                            image: NetworkImage(
                                "https://i.pinimg.com/564x/40/a4/2f/40a42f4b27a14089b82a916aaff0b298.jpg"),
                          ),
                          Text(
                            'Open cafe',
                            style: SwitchTexts.bodyDefaultBold(
                                SwitchColors.steel_gray_100),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Image(
                            width: 36,
                            height: 36,
                            image: NetworkImage(
                                "https://i.pinimg.com/564x/40/a4/2f/40a42f4b27a14089b82a916aaff0b298.jpg"),
                          ),
                          Text(
                            'Open cafe',
                            style: SwitchTexts.bodyDefaultBold(
                                SwitchColors.steel_gray_100),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
