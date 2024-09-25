import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/features/linkSwitchRoom/presentation/pages/linkSwitchRoom_page.dart';
import 'package:switchfrontend/src/features/listSchedule/presentation/pages/listSchedule_page.dart';


class CardSchedule extends StatefulWidget {
  final String automationName; 

  const CardSchedule({Key? key, required this.automationName}) : super(key: key); 

  @override
  _CardScheduleState createState() => _CardScheduleState();
}

class _CardScheduleState extends State<CardSchedule> {
  String _selectedAction = 'Início e Fim';
  TimeOfDay _startTime = TimeOfDay(hour: 7, minute: 30);
  TimeOfDay _endTime = TimeOfDay(hour: 7, minute: 30);
  TimeOfDay _singleTime = TimeOfDay(hour: 7, minute: 30);
  
  bool _isOnStart = true;
  bool _isOnEnd = false;
  
  final List<bool> _selectedDays = List.generate(7, (_) => false);
  final TextStyle _labelStyle = TextStyle(color: Colors.white, fontSize: 16);
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
    child: Text('Editar Automatização', style: SwitchTexts.titleBody(SwitchColors.steel_gray_50).copyWith(fontWeight: FontWeight.bold).copyWith(fontSize: 18)),
  ),
  centerTitle: true,
  iconTheme: IconThemeData(color: Colors.white),
  actions: [
    IconButton(
      icon: Icon(Icons.delete, color: Color.fromARGB(255, 157, 50, 43)), 
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
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: _nameController,
                maxLength: 20,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'.{0,20}')),
                ],
                style: TextStyle(color: Colors.white),
                cursorColor: SwitchColors.ui_blueziness_800,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: SwitchColors.ui_blueziness_800),
                  ),
                  counterStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (_) {
                  setState(() {
                    _isEdited = true;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              dropdownColor: SwitchColors.steel_gray_950,
              value: _selectedAction,
              items: <String>['Início e Fim', 'Só uma Ação'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAction = newValue!;
                  _isEdited = true;
                });
              },
            ),
            SizedBox(height: 20),
            if (_selectedAction == 'Início e Fim') ...[
              _buildCard('Início', _startTime, _isOnStart, (time) {
                setState(() {
                  _startTime = time;
                  _isEdited = true;
                });
              }, (bool value) {
                setState(() {
                  _isOnStart = value;
                  _isOnEnd = !value;
                  _isEdited = true;
                });
              }),
              SizedBox(height: 20),
              _buildCard('Fim', _endTime, _isOnEnd, (time) {
                setState(() {
                  _endTime = time;
                  _isEdited = true;
                });
              }, (bool value) {
                setState(() {
                  _isOnEnd = value;
                  _isOnStart = !value;
                  _isEdited = true;
                });
              }),
            ] else ...[
              _buildSingleActionCard(),
            ],
            SizedBox(height: 20),
            Text('Selecione os dias', style: TextStyle(color: Colors.white)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                return _buildDayButton(index);
              }),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _isEdited ? () {
                      _resetForm();
                    } : null,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: _isEdited ? SwitchColors.ui_blueziness_800 : Colors.grey),
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
                SizedBox(width: 20),
                Expanded(
                  child: TextButton(
                    onPressed: _isEdited ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LinkSwitchRoom(),
                        ),
                      );
                    } : null,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: _isEdited ? SwitchColors.ui_blueziness_800 : Colors.grey,
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
          side: BorderSide(color: Colors.grey),
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
            child: Text(
              'cancelar',
              style: TextStyle(color: SwitchColors.ui_blueziness_800, fontSize: 16)
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ListSchedule()),
                (route) => false,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Automatização '${widget.automationName}' excluída.")),
              );
            },
            child: Text(
              'excluir',
              style: TextStyle(color: SwitchColors.ui_blueziness_800, fontSize: 16),
            ),
          ),
        ],
      );
    },
  );
}
  Widget _buildCard(
    String title,
    TimeOfDay time,
    bool isOn,
    ValueChanged<TimeOfDay> onTimeChanged,
    ValueChanged<bool> onSwitchChanged,
  ) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white)),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    TimeOfDay? pickedTime = await _selectTime(context, time);
                    if (pickedTime != null) {
                      onTimeChanged(pickedTime);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(time.format(context), style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(isOn ? 'On' : 'Off', style: TextStyle(color: Colors.white)),
                Switch(
                  value: isOn,
                  onChanged: onSwitchChanged,
                  activeColor: SwitchColors.ui_blueziness_800,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleActionCard() {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                TimeOfDay? pickedTime = await _selectTime(context, _singleTime);
                if (pickedTime != null) {
                  setState(() {
                    _singleTime = pickedTime;
                    _isEdited = true;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(_singleTime.format(context), style: TextStyle(color: Colors.white)),
              ),
            ),
            Switch(
              value: _isOnStart,
              onChanged: (bool value) {
                setState(() {
                  _isOnStart = value;
                  _isEdited = true;
                });
              },
              activeColor: SwitchColors.ui_blueziness_800,
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildDayButton(int index) {
    final days = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDays[index] = !_selectedDays[index];
          _isEdited = true; // Marca como editado
        });
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedDays[index] ? SwitchColors.ui_blueziness_800 : Colors.white,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          days[index],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


Future<TimeOfDay?> _selectTime(BuildContext context, TimeOfDay initialTime) {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: Theme(
          data: ThemeData(
            brightness: Brightness.dark,
            primaryColor: SwitchColors.ui_blueziness_800,
            dialogBackgroundColor: Colors.black,
            colorScheme: ColorScheme.dark(
              primary: SwitchColors.ui_blueziness_800,
              onPrimary: SwitchColors.steel_gray_50,
              onSurface: Colors.grey,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.white), 
              bodyText2: TextStyle(color: Colors.white),
              
            ),
          ),
          child: child!,
        ),
      );
    },
        helpText: 'selecione um horário:',
  );
}

  void _resetForm() {
    setState(() {
      _nameController.clear();
      _selectedAction = 'Início e Fim';
      _startTime = TimeOfDay(hour: 7, minute: 30);
      _endTime = TimeOfDay(hour: 7, minute: 30);
      _singleTime = TimeOfDay(hour: 7, minute: 30);
      _isOnStart = true;
      _isOnEnd = false;
      _selectedDays.fillRange(0, _selectedDays.length, false);
      _isEdited = false;
    });
  }
}
