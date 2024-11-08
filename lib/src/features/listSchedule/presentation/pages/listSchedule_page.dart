import 'package:flutter/material.dart';
import 'package:switchfrontend/src/features/home/presentation/pages/home_page.dart';
import 'package:switchfrontend/src/features/listSchedule/list-schedule.bloc.dart';
import 'package:switchfrontend/src/features/listSchedule/models/schedule.model.dart';
import 'package:switchfrontend/src/features/schedule/presentation/pages/schedule_page.dart';
import 'package:switchfrontend/src/features/cardSchedule/presentation/pages/cardSchedule_page.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class ListSchedule extends StatefulWidget {
  const ListSchedule({super.key});

  @override
  _ListScheduleState createState() => _ListScheduleState();
}

class _ListScheduleState extends State<ListSchedule> {
  List<ScheduleModel> _schedules = [];
  bool loading = false;

  @override
  void initState() {
    getSchedules();
    super.initState();
  }

  void _addSchedule() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Schedule()),
    );
  }

  void _toggleSchedule(int index, bool? value) {
    setState(() {
      _schedules[index].isActive = value!;
    });
  }

  void _editSchedule(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardSchedule(
          automationName: _schedules[index].eventName,
        ),
      ),
    );
  }

  void getSchedules() async {
    setState(() {
      loading = true;
    });

    try {
      var response = await ListScheduleBloc.getSchedules();
      setState(() {
        _schedules = response;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SwitchColors.steel_gray_950,
      appBar: AppBar(
        backgroundColor: SwitchColors.steel_gray_950,
        title: Row(
          children: [
            const Spacer(flex: 2),
            Text(
              'Automatizações',
              style: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Spacer(flex: 3),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
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
                itemCount: _schedules.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ScheduleCard(
                        title: _schedules[index].eventName,
                        eventDate: _schedules[index].eventDate.eventDate,
                        days: [_schedules[index].eventDate.dayOfWeek],
                        isEnabled: _schedules[index].isActive,
                        onToggle: (value) => _toggleSchedule(index, value),
                        onEdit: () => _editSchedule(index),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
            const Divider(color: Colors.grey),
            ListTile(
              title: const Text(
                'Adicionar Automatização',
                style: TextStyle(color: Colors.white),
              ),
              trailing: const Icon(Icons.add, color: Colors.white),
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
  final String eventDate;
  final List<String> days;
  final bool isEnabled;
  final ValueChanged<bool?> onToggle;
  final VoidCallback onEdit;

  const ScheduleCard({
    super.key,
    required this.title,
    required this.eventDate,
    required this.days,
    required this.isEnabled,
    required this.onToggle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        eventDate,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        daysOfWeek,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
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
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
