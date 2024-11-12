import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:switchfrontend/src/features/home/home.bloc.dart';
import 'package:switchfrontend/src/features/home/models/home_data.model.dart';
import 'package:switchfrontend/src/features/home/models/schedule.model.dart';
import 'package:switchfrontend/src/features/listSchedule/models/schedule.model.dart';
import 'package:switchfrontend/src/features/listSchedule/presentation/pages/listSchedule_page.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/features/listSwitch/presentation/pages/listSwitch_page.dart';
import 'package:switchfrontend/src/features/listRoom/presentation/pages/listRoom_page.dart';
import 'package:switchfrontend/src/features/login/presentation/pages/login_page.dart';

class SwitchIcon extends StatelessWidget {
  const SwitchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(40, 40),
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
        const Rect.fromLTWH(5, 10, 30, 20),
        const Radius.circular(10),
      ),
      paint,
    );

    paint.style = PaintingStyle.fill;
    paint.color = Colors.blueAccent;
    canvas.drawCircle(const Offset(15, 20), 6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RoomIcon extends StatelessWidget {
  const RoomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(40, 40),
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
      const Rect.fromLTWH(10, 8, 20, 24),
      paint,
    );

    paint.style = PaintingStyle.fill;
    paint.color = Colors.blueAccent;
    canvas.drawCircle(const Offset(25, 20), 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AutomationIcon extends StatelessWidget {
  const AutomationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(40, 40),
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

    canvas.drawCircle(const Offset(12, 15), 6, paint);
    canvas.drawCircle(const Offset(28, 25), 6, paint);

    paint.color = Colors.blueAccent;
    paint.strokeWidth = 2.0;
    canvas.drawLine(const Offset(18, 15), const Offset(22, 25), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";

  bool loading = false;
  List<ModelSchedule> automations = [];

  getData() async {
    setState(() {
      loading = true;
    });

    HomeDataModel data = await HomeBloc.getData();

    setState(() {
      userName = data.user.name;

      automations = data.schedules;

      loading = false;
    });
  }

  String _getGreeting(int hour) {
    if (hour < 12) {
      return 'Bom dia';
    } else if (hour < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }

  Widget _buildCarousel() {
    return automations.isNotEmpty
        ? Container(
            height: 140,
            margin: const EdgeInsets.only(top: 15, bottom: 36),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: automations.length,
              itemBuilder: (context, index) {
                return _buildCarouselItem(
                  automations[index].action,
                  '${cronToDescriptiveSentence(automations[index].time).dayOfWeek} às ${cronToDescriptiveSentence(automations[index].time).eventDate}',
                );
              },
            ),
          )
        : const SizedBox();
  }

  Widget _buildCarouselItem(String action, String time) {
    return Container(
      width: 138,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border:
            Border.all(color: const Color.fromARGB(255, 1, 41, 74), width: 1.1),
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.access_time,
                  color: SwitchColors.steel_gray_100, size: 16),
              const SizedBox(width: 4),
              SizedBox(
                width: 99,
                child: Text(
                  time,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: SwitchTexts.titleBody(SwitchColors.steel_gray_100)
                      .copyWith(fontSize: 13),
                ),
              ),
            ],
          ),
          Expanded(
            child: Text(
              action,
              textAlign: TextAlign.left,
              style: SwitchTexts.titleBody(SwitchColors.steel_gray_100)
                  .copyWith(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationInfo(BuildContext context) {
    String remainingTime = '1h30min';

    return Container(
      margin: const EdgeInsets.only(top: 1),
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
                  style: SwitchTexts.titleBody(SwitchColors.steel_gray_100)
                      .copyWith(fontSize: 17),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                Text(
                  remainingTime,
                  style: SwitchTexts.titleBody(SwitchColors.steel_gray_100)
                      .copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 170,
            height: 120,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(255, 1, 41, 74), width: 0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.power, color: SwitchColors.steel_gray_100, size: 24),
                const SizedBox(height: 15),
                Text(
                  'Ativar luzes',
                  style: SwitchTexts.titleBody(SwitchColors.steel_gray_100)
                      .copyWith(fontSize: 18),
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
            side: const BorderSide(
                color: Color.fromARGB(255, 1, 35, 64), width: 0.9),
          ),
          title: Center(
            child: Text(
              'SWITCH',
              style: SwitchTexts.titleBody(SwitchColors.steel_gray_100)
                  .copyWith(fontSize: 18),
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
                  MaterialPageRoute(builder: (context) => const LoginPage()),
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

  Widget _buildCategoryTile(BuildContext context,
      {required Widget icon,
      required String label,
      required VoidCallback onTap,
      bool fullWidth = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: const Color.fromARGB(255, 0, 49, 92), width: 2.2),
        ),
        width: fullWidth
            ? double.infinity
            : (MediaQuery.of(context).size.width / 2) - (2 * 12),
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(height: 8),
            Text(
              label,
              style: SwitchTexts.titleBody(SwitchColors.steel_gray_100),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: SwitchColors.steel_gray_950),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _showLogoutDialog(context),
                  child: Image.asset(
                    'lib/assets/logoswitchhome.png',
                    width: 45,
                    height: 45,
                  ),
                ),
              ],
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
                        style:
                            SwitchTexts.titleBody(SwitchColors.steel_gray_100),
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
                                  MaterialPageRoute(
                                      builder: (context) => SwitchesPage()),
                                ),
                              ),
                              _buildCategoryTile(
                                context,
                                icon: RoomIcon(),
                                label: 'rooms',
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListRoom(),
                                  ),
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
                              MaterialPageRoute(
                                  builder: (context) => ListSchedule()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Color.fromARGB(255, 44, 73, 97),
                      thickness: 1.0,
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
    );
  }
}
