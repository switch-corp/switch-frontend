import 'package:flutter/material.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/features/listSwitch/presentation/pages/listSwitch_page.dart';
import 'package:switchfrontend/src/features/addRoom/presentation/pages/addRoom_page.dart';
import 'package:switchfrontend/src/features/listRoom/presentation/pages/listRoom_page.dart';
import 'package:switchfrontend/src/features/ListSchedule/presentation/pages/ListSchedule_page.dart';
import 'package:switchfrontend/src/features/login/presentation/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _getGreeting(int hour) {
    if (hour < 12) {
      return 'Bom dia';
    } else if (hour < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }

  List<Map<String, String>> _getEnabledAutomations() {
    return [
      {'action': 'Ativar luzes', 'time': '18:00'},
      {'action': 'Desligar ar-condicionado', 'time': '22:00'},
      {'action': 'Abrir cortinas', 'time': '08:00'},
      {'action': 'Fechar janelas', 'time': '20:00'},
      {'action': 'Ligar aquecedor', 'time': '07:00'},
      {'action': 'Desligar luzes', 'time': '23:00'},
    ];
  }

  Widget _buildCarousel() {
    final automations = _getEnabledAutomations();

    return Container(
      height: 120,
      margin: EdgeInsets.only(top: 32),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: automations.length,
        itemBuilder: (context, index) {
          return _buildCarouselItem(
            automations[index]['action']!,
            automations[index]['time']!,
          );
        },
      ),
    );
  }

  Widget _buildCarouselItem(String action, String time) {
    return Container(
      width: 120,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: SwitchColors.steel_gray_600),
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.access_time, color: SwitchColors.steel_gray_100, size: 16),
              SizedBox(width: 4),
              Text(
                time,
                textAlign: TextAlign.center,
                style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(fontSize: 13),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                action,
                textAlign: TextAlign.center,
                style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
Widget _buildAutomationInfo(BuildContext context) {
  String remainingTime = '1h30min';

  return Container(
    margin: EdgeInsets.only(top: 32),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    width: MediaQuery.of(context).size.width * 0.95,
    height: 109,
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'próximo evento em:',
                style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(fontSize: 17),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2),
              Text(
                remainingTime,
                style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 165,
          height: 109,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: SwitchColors.steel_gray_600),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.power, color: SwitchColors.steel_gray_100, size: 24),
              SizedBox(height: 4),
              Text(
                'Ativar luzes',
                style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}



void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: SwitchColors.steel_gray_950,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), 
          side: BorderSide(color: SwitchColors.steel_gray_600, width: 1),
        ),
        title: Center(
          child: Text(
            'SWITCH',
            style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(fontSize: 18),
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  'você deseja fazer logout?',
                  style: SwitchTexts.titleBody(SwitchColors.steel_gray_100),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'não',
              style: SwitchTexts.titleBody(SwitchColors.ui_blueziness_800),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text(
              'sim',
              style: SwitchTexts.titleBody(SwitchColors.ui_blueziness_800),
            ),
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;

    String userName = "Usuário12131";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SwitchColors.steel_gray_950,
        elevation: 0,
        toolbarHeight: 20,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: SwitchColors.steel_gray_950,
          ),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _showLogoutDialog(context),
                  child: Image.asset(
                    'lib/assets/logoswitchhome.png',
                    width: 36,
                    height: 36,
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    '${_getGreeting(hour)}, $userName!',
                    style: SwitchTexts.titleBody(SwitchColors.steel_gray_100),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 19),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SwitchesPage(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: SwitchColors.steel_gray_600),
                                ),
                                width: (MediaQuery.of(context).size.width / 2) - (2 * 12),
                                height: 128,
                                child: Text(
                                  'switches',
                                  style: SwitchTexts.titleBody(SwitchColors.steel_gray_100),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListRoom(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: SwitchColors.steel_gray_600),
                                ),
                                width: (MediaQuery.of(context).size.width / 2) - (2 * 12),
                                height: 128,
                                child: Text(
                                  'rooms',
                                  style: SwitchTexts.titleBody(SwitchColors.steel_gray_100),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListSchedule(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(color: SwitchColors.steel_gray_600),
                                  ),
                                  height: 128,
                                  child: Text(
                                    'automatizações',
                                    style: SwitchTexts.titleBody(SwitchColors.steel_gray_100),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                _buildCarousel(),
                SizedBox(height: 20),
                _buildAutomationInfo(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
