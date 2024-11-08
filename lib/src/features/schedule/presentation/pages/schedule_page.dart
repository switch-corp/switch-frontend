import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:switchfrontend/src/features/listSchedule/models/schedule.model.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/features/linkSwitchRoom/presentation/pages/linkSwitchRoom_page.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  TimeOfDay _singleTime = const TimeOfDay(hour: 7, minute: 30);
  bool _isActionOn = true; // Ação inicial como "on"
  final List<bool> _selectedDays = List.generate(7, (_) => false);
  final TextStyle _labelStyle =
      const TextStyle(color: Colors.white, fontSize: 16);
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
        title: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text('Adicionar Automatização',
              style: TextStyle(color: Colors.white)),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
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
                    _isEdited = true; // Marca como editado
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            _buildSingleActionCard(),
            const SizedBox(height: 20),
            const Text(
              'Selecione os dias',
              style: TextStyle(color: Colors.white),
            ),
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
                            // Limpa o nome da automatização e redefine as configurações
                            _nameController.clear();
                            _singleTime = const TimeOfDay(hour: 7, minute: 30);
                            _isActionOn = true; // Reseta a ação para "on"
                            for (int i = 0; i < _selectedDays.length; i++) {
                              _selectedDays[i] = false;
                            }
                            setState(() {
                              _isEdited = false; // Reseta o estado
                            });
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
                    onPressed: _isEdited && _nameController.text.isNotEmpty
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LinkSwitchRoom(),
                              ),
                            );
                          }
                        : null,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor:
                          (_isEdited && _nameController.text.isNotEmpty)
                              ? SwitchColors.ui_blueziness_800
                              : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'CONTINUAR',
                      style: TextStyle(
                        color: (_isEdited && _nameController.text.isNotEmpty)
                            ? Colors.white
                            : Colors.black,
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

  Widget _buildSingleActionCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda
      children: [
        const Padding(
          padding: EdgeInsets.only(
              left: 16.0, right: 16.0, bottom: 8.0), // Ajusta o espaçamento
          child: Text(
            "Selecione o Horário e a Ação:", // Texto acima da caixa
            style: TextStyle(
                color: Colors.white, fontSize: 16.0), // Estilo do texto
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
                        _isEdited = true; // Marca como editado
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
                    child: Text(
                      _singleTime.format(context),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                // Botão de alternância
                Row(
                  children: [
                    Text(
                      _isActionOn ? "on" : "off", // Texto de estado
                      style: const TextStyle(color: Colors.white),
                    ),
                    Switch(
                      value: _isActionOn, // Controla o estado do botão
                      onChanged: (value) {
                        setState(() {
                          _isActionOn = value; // Atualiza o estado ao alternar
                          _isEdited = true; // Marca como editado ao mudar
                        });
                      },
                      activeColor:
                          SwitchColors.ui_blueziness_800, // Cor quando ativado
                      inactiveThumbColor: Colors.grey, // Cor quando desativado
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
          _isEdited = true; // Marca como editado
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedDays[index]
                ? SwitchColors.ui_blueziness_800
                : Colors.white,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          days[index],
          style: const TextStyle(
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
              ),
            ),
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
