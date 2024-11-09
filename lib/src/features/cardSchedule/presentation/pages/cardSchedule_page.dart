import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/features/linkSwitchRoom/presentation/pages/linkSwitchRoom_page.dart';
import 'package:switchfrontend/src/features/listSchedule/presentation/pages/listSchedule_page.dart';

class CardSchedule extends StatefulWidget {
  final String automationName;

  const CardSchedule({super.key, required this.automationName});

  @override
  _CardScheduleState createState() => _CardScheduleState();
}

class _CardScheduleState extends State<CardSchedule> {
  TimeOfDay _singleTime = const TimeOfDay(hour: 7, minute: 30);
  bool _isOnSingle = true;

  final List<bool> _selectedDays = List.generate(7, (_) => false);
  final TextStyle _labelStyle =
      const TextStyle(color: Colors.white, fontSize: 16);
  final TextEditingController _nameController = TextEditingController();
  bool _isEdited = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.automationName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SwitchColors.steel_gray_950,
      appBar: AppBar(
        backgroundColor: SwitchColors.steel_gray_950,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text('Editar Automatização',
              style: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
                  .copyWith(fontWeight: FontWeight.bold)
                  .copyWith(fontSize: 18)),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete,
                color: Color.fromARGB(255, 157, 50, 43)),
            onPressed: () {
              _confirmDeleteAutomation();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Digite o nome da Automatização',
                style: _labelStyle,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: _nameController,
                maxLength: 20,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'.{0,20}')),
                ],
                style: const TextStyle(color: Colors.white),
                cursorColor: SwitchColors.ui_blueziness_800,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: SwitchColors.ui_blueziness_800),
                  ),
                  counterStyle: const TextStyle(color: Colors.grey),
                ),
                onChanged: (_) {
                  setState(() {
                    _isEdited = true;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            // Apenas o card de ação única
            _buildSingleActionCard(),
            const SizedBox(height: 20),
            const Text('Selecione os dias',
                style: TextStyle(color: Colors.white)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                return _buildDayButton(index);
              }),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _isEdited
                        ? () {
                            _resetForm();
                          }
                        : null,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.transparent,
                      side: BorderSide(
                          color: _isEdited
                              ? SwitchColors.ui_blueziness_800
                              : Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'CANCELAR',
                      style: TextStyle(
                        color: _isEdited ? Colors.white : Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextButton(
                    onPressed: _isEdited
                        ? () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => LinkSwitchRoom(),
                            //   ),
                            // );
                          }
                        : null,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: _isEdited
                          ? SwitchColors.ui_blueziness_800
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'CONTINUAR',
                      style: TextStyle(
                        color: _isEdited ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteAutomation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: SwitchColors.steel_gray_950,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.grey),
          ),
          title: Center(
            child: Text(
              'SWITCH',
              style: SwitchTexts.titleBody(SwitchColors.steel_gray_50).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    'Você tem certeza que deseja excluir a automatização "${widget.automationName}"?',
                    style: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
                        .copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
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
              child: Text('cancelar',
                  style: TextStyle(
                      color: SwitchColors.ui_blueziness_800, fontSize: 16)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const ListSchedule()),
                  (route) => false,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          "Automatização '${widget.automationName}' excluída.")),
                );
              },
              child: Text(
                'excluir',
                style: TextStyle(
                    color: SwitchColors.ui_blueziness_800, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSingleActionCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Texto posicionado acima do Card com Padding
        const Padding(
          padding: EdgeInsets.only(
              bottom: 8.0, left: 15.0), // Adiciona um pequeno padding
          child: Text(
            'Selecione o Horário e a Ação:',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Card(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    TimeOfDay? pickedTime =
                        await _selectTime(context, _singleTime);
                    if (pickedTime != null) {
                      setState(() {
                        _singleTime = pickedTime;
                        _isEdited = true;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(_singleTime.format(context),
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      _isOnSingle ? 'on' : 'off',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Switch(
                      value: _isOnSingle,
                      onChanged: (bool value) {
                        setState(() {
                          _isOnSingle = value;
                          _isEdited = true;
                        });
                      },
                      activeColor: SwitchColors.ui_blueziness_800,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayButton(int index) {
    final days = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDays[index] = !_selectedDays[index];
          _isEdited = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: _selectedDays[index]
                  ? SwitchColors.ui_blueziness_800
                  : Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: _selectedDays[index]
              ? SwitchColors.ui_blueziness_800
              : Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(
          days[index],
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<TimeOfDay?> _selectTime(
      BuildContext context, TimeOfDay initialTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    return pickedTime;
  }

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _singleTime = TimeOfDay.now();
      _isOnSingle = true;
      _selectedDays.fillRange(0, 7, false);
      _isEdited = false;
    });
  }
}
