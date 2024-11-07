import 'package:flutter/material.dart';
import 'package:switchfrontend/src/features/home/presentation/pages/home_page.dart';
import 'package:switchfrontend/src/features/schedule/presentation/pages/schedule_page.dart';
import 'package:switchfrontend/src/features/cardSchedule/presentation/pages/cardSchedule_page.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class ListSchedule extends StatefulWidget {
  @override
  _ListScheduleState createState() => _ListScheduleState();
}

class _ListScheduleState extends State<ListSchedule> {
  List<Map<String, dynamic>> schedules = [
    {
      "title": "Automatização 1",
      "description": "Ativa luzes",
      "enabled": false,
      "startTime": "18:00",
      "endTime": null,
      "days": ["Segunda", "Quarta", "Sexta"]
    },
    {
      "title": "Automatização 2",
      "description": "Desliga ar-condicionado",
      "enabled": false,
      "startTime": "23:00",
      "endTime": null,
      "days": ["Terça", "Quinta"]
    },
    {
      "title": "Automatização 3",
      "description": "Liga ventilador",
      "enabled": false,
      "startTime": "15:00",
      "endTime": "16:00",
      "days": ["Sábado"]
    },
  ];

  void _addSchedule() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Schedule()),
    );
  }

  void _toggleSchedule(int index, bool? value) {
    setState(() {
      schedules[index]['enabled'] = value!;
    });
  }

  void _editSchedule(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardSchedule(automationName: schedules[index]['title']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SwitchColors.steel_gray_950,
      appBar: AppBar(
  backgroundColor: SwitchColors.steel_gray_950,
  title: Row(
    children: [
      Spacer(flex: 2), 
      Text(
        'Automatizações',
        style: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      Spacer(flex: 3), 
    ],
  ),
  leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    },
  ),
  automaticallyImplyLeading: false,
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ScheduleCard(
                        title: schedules[index]['title']!,
                        startTime: schedules[index]['startTime']!,
                        endTime: schedules[index]['endTime'],
                        days: schedules[index]['days'],
                        isEnabled: schedules[index]['enabled'],
                        onToggle: (value) => _toggleSchedule(index, value),
                        onEdit: () => _editSchedule(index),
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text(
                'Adicionar Automatização',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.add, color: Colors.white),
              onTap: _addSchedule,
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final String title;
  final String startTime;
  final String? endTime;
  final List<String> days;
  final bool isEnabled;
  final ValueChanged<bool?> onToggle;
  final VoidCallback onEdit;

  const ScheduleCard({
    required this.title,
    required this.startTime,
    this.endTime,
    required this.days,
    required this.isEnabled,
    required this.onToggle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    String scheduleTime = endTime != null ? "$startTime - $endTime" : "$startTime";
    String daysOfWeek = days.join(", ");

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        scheduleTime,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        "$daysOfWeek",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey[400], size: 23),
                  onPressed: onEdit,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch(
                  value: isEnabled,
                  onChanged: onToggle,
                  activeColor: Colors.blueAccent,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.withOpacity(0.5),
                ),
                Text(
                  isEnabled ? 'ativado' : 'desativado',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
