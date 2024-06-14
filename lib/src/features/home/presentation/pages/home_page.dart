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
                Row(
                  children: [
                    Text(
                      'Home',
                      style: SwitchTests.title_screen,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
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
                          width: 165,
                          height: 128,
                          child: Text(
                            'rooms',
                            style: SwitchTests.title_body,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(color: SwitchColors.steel_gray_100),
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.height,
    // );
  }
}
