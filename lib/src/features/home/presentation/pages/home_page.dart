import 'package:flutter/material.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/features/listSwitch/presentation/pages/listSwitch_page.dart';
import 'package:switchfrontend/src/features/listRoom/presentation/pages/listRoom_page.dart';
import 'package:switchfrontend/src/features/ListSchedule/presentation/pages/ListSchedule_page.dart';
import 'package:switchfrontend/src/features/login/presentation/pages/login_page.dart';

class SwitchIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(40, 40),
      painter: SwitchIconPainter(),
    );
  }
}

class SwitchIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(5, 10, 30, 20),
        Radius.circular(10),
      ),
      paint,
    );

    paint.style = PaintingStyle.fill;
    paint.color = Colors.blueAccent;
    canvas.drawCircle(Offset(15, 20), 6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RoomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(40, 40),
      painter: RoomIconPainter(),
    );
  }
}

class RoomIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawRect(
      Rect.fromLTWH(10, 8, 20, 24),
      paint,
    );

    paint.style = PaintingStyle.fill;
    paint.color = Colors.blueAccent;
    canvas.drawCircle(Offset(25, 20), 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AutomationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(40, 40),
      painter: AutomationIconPainter(),
    );
  }
}

class AutomationIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawCircle(Offset(12, 15), 6, paint);
    canvas.drawCircle(Offset(28, 25), 6, paint);

    paint.color = Colors.blueAccent;
    paint.strokeWidth = 2.0;
    canvas.drawLine(Offset(18, 15), Offset(22, 25), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

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
    ];
  }

  Widget _buildCarousel() {
    final automations = _getEnabledAutomations();

    return Container(
      height: 140,
      margin: EdgeInsets.only(top: 15, bottom: 36),
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
      width: 138,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 1, 41, 74), width: 0.8),
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: Text(
              action,
              textAlign: TextAlign.left,
              style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationInfo(BuildContext context) {
    String remainingTime = '1h30min';

    return Container(
      margin: EdgeInsets.only(top: 1),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      width: MediaQuery.of(context).size.width * 0.95,
      height: 125,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'próximo evento em:',
                  style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(fontSize: 17),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                Text(
                  remainingTime,
                  style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 170,
            height: 120,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 1, 41, 74), width: 0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.power, color: SwitchColors.steel_gray_100, size: 24),
                SizedBox(height: 15),
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
            side: BorderSide(color: Color.fromARGB(255, 1, 35, 64), width: 0.9),
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
    String userName = "Usuário";

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: SwitchColors.steel_gray_950),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _showLogoutDialog(context),
                child: Image.asset(
                  'lib/assets/logoswitchhome.png',
                  width: 36,
                  height: 36,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          '${_getGreeting(hour)}, $userName!',
                          style: SwitchTexts.titleBody(SwitchColors.steel_gray_100),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 28),
                      Container(
                        padding: EdgeInsets.all(4),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildCategoryTile(
                                  context,
                                  icon: SwitchIcon(),
                                  label: 'switches',
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SwitchesPage()),
                                  ),
                                ),
                                _buildCategoryTile(
                                  context,
                                  icon: RoomIcon(),
                                  label: 'rooms',
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ListRoom()),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            _buildCategoryTile(
                              context,
                              icon: AutomationIcon(),
                              label: 'automatizações',
                              fullWidth: true,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ListSchedule()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color.fromARGB(255, 44, 73, 97),
                        thickness: 0.6,
                        indent: 10,
                        endIndent: 10,
                      ),
                      _buildAutomationInfo(context),
                      _buildCarousel(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTile(BuildContext context, {required Widget icon, required String label, required VoidCallback onTap, bool fullWidth = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color.fromARGB(255, 0, 49, 92), width: 2.2),
        ),
        width: fullWidth ? double.infinity : (MediaQuery.of(context).size.width / 2) - (2 * 12),
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            SizedBox(height: 8),
            Text(
              label,
              style: SwitchTexts.titleBody(SwitchColors.steel_gray_100),
            ),
          ],
        ),
      ),
    );
  }
}
