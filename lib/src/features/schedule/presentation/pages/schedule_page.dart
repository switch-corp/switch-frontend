import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/features/linkSwitchRoom/presentation/pages/linkSwitchRoom_page.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  String _selectedAction = 'Início e Fim';
  TimeOfDay _startTime = TimeOfDay(hour: 7, minute: 30);
  TimeOfDay _endTime = TimeOfDay(hour: 7, minute: 30);
  TimeOfDay _singleTime = TimeOfDay(hour: 7, minute: 30);

  bool _isOnStart = true;
  bool _isOnEnd = false;

  final List<bool> _selectedDays = List.generate(7, (_) => false);
  
  final TextStyle _labelStyle = TextStyle(color: Colors.white, fontSize: 16);
  final TextEditingController _nameController = TextEditingController();
  bool _isEdited = false; // Variável para rastrear se houve edição

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
    padding: const EdgeInsets.only(left: 10.0), // Ajuste o valor conforme necessário
    child: Text('Adicionar Automatização', style: TextStyle(color: Colors.white)),
  ),
  centerTitle: true,
  iconTheme: IconThemeData(color: Colors.white),
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
                  hintText: null,
                  counterStyle: TextStyle(color: Colors.grey), // Define a cor do contador
                ),
                onChanged: (_) {
                  setState(() {
                    _isEdited = true; // Marca como editado
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
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAction = newValue!;
                  _isEdited = true; // Marca como editado
                });
              },
            ),
            SizedBox(height: 20),
            if (_selectedAction == 'Início e Fim') ...[
              _buildCard(
                'Início',
                _startTime,
                _isOnStart,
                (time) {
                  setState(() {
                    _startTime = time;
                    _isEdited = true; // Marca como editado
                  });
                },
                (bool value) {
                  setState(() {
                    _isOnStart = value;
                    _isOnEnd = !value;
                    _isEdited = true; // Marca como editado
                  });
                },
              ),
              SizedBox(height: 20),
              _buildCard(
                'Fim',
                _endTime,
                _isOnEnd,
                (time) {
                  setState(() {
                    _endTime = time;
                    _isEdited = true; // Marca como editado
                  });
                },
                (bool value) {
                  setState(() {
                    _isOnEnd = value;
                    _isOnStart = !value;
                    _isEdited = true; // Marca como editado
                  });
                },
              ),
            ] else ...[
              _buildSingleActionCard(),
            ],
            SizedBox(height: 20),
            Text(
              'Selecione os dias',
              style: TextStyle(color: Colors.white),
            ),
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
                      // Limpa o nome da automatização
                      _nameController.clear();

                      // Redefine o horário para o padrão
                      _startTime = TimeOfDay(hour: 7, minute: 30);
                      _endTime = TimeOfDay(hour: 7, minute: 30);
                      _singleTime = TimeOfDay(hour: 7, minute: 30);

                      // Desmarca todos os dias da semana
                      for (int i = 0; i < _selectedDays.length; i++) {
                        _selectedDays[i] = false;
                      }

                      setState(() {
                        _isEdited = false; // Reseta o estado
                      });
                    } : null, // Desabilita o botão se não houve edição
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
                      // Aqui você pode adicionar a lógica para continuar
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LinkSwitchRoom(),
                        ),
                      );
                    } : null, // Desabilita o botão se não houve edição
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: _isEdited ? SwitchColors.ui_blueziness_800: Colors.grey, // Azul se editado, cinza caso contrário
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'CONTINUAR',
                      style: TextStyle(
                        color: _isEdited ? Colors.white : Colors.black, // Branco se editado, transparente caso contrário
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
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
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
                    child: Text(
                      time.format(context),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  isOn ? 'On' : 'Off',
                  style: TextStyle(color: Colors.white),
                ),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    TimeOfDay? pickedTime = await _selectTime(context, _singleTime);
                    if (pickedTime != null) {
                      setState(() {
                        _singleTime = pickedTime;
                        _isEdited = true; // Marca como editado
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      _singleTime.format(context),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  _isOnStart ? 'On' : 'Off',
                  style: TextStyle(color: Colors.white),
                ),
                Switch(
                  value: _isOnStart,
                  onChanged: (bool value) {
                    setState(() {
                      _isOnStart = value;
                      _isEdited = true; // Marca como editado
                    });
                  },
                  activeColor: SwitchColors.ui_blueziness_800,
                ),
              ],
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
            primaryColor: SwitchColors.ui_blueziness_800, // Cor do botão
            dialogBackgroundColor: Colors.black, // Cor de fundo do diálogo
            colorScheme: ColorScheme.dark(
              primary: SwitchColors.ui_blueziness_800,
              onPrimary: SwitchColors.steel_gray_50,
              onSurface: Colors.grey, // Cor do círculo
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.white), // Texto em branco
              bodyText2: TextStyle(color: Colors.white), // Texto em branco
            ),
            // Você pode adicionar mais estilos de texto se necessário
          ),
          child: child!,
        ),
      );
    },
        helpText: 'selecione um horário:',
  );
}

}
