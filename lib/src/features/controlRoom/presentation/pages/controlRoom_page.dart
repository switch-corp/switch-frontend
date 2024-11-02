import 'package:flutter/material.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/features/listSwitch/presentation/pages/listSwitch_page.dart';

class ControlRoom extends StatefulWidget {
  final String roomName;
  final String roomDescription;

  ControlRoom({required this.roomName, required this.roomDescription});

  @override
  _ControlRoomState createState() => _ControlRoomState();
}

class _ControlRoomState extends State<ControlRoom> {
  bool _roomOn = false;

  void _toggleRoom() {
    setState(() {
      _roomOn = !_roomOn;
    });
  }

  void _confirmDeleteRoom() {
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
              'ROOM',
              style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(fontSize: 18),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    'Você tem certeza que deseja excluir a room "${widget.roomName}"?',
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
                'Cancelar',
                style: SwitchTexts.titleBody(SwitchColors.ui_blueziness_800),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SwitchesPage()),
                  (route) => false,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Room '${widget.roomName}' excluída.")),
                );
              },
              child: Text(
                'Excluir',
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
  // Lista fictícia de switches vinculados
  final List<String> linkedSwitches = [
    "Luz da Sala",
    "Ventilador",
    "Aquecedor",
    "Projeto de Som",
  ];

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Ligar/Desligar Room',
        style: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
            .copyWith(fontWeight: FontWeight.bold)
            .copyWith(fontSize: 18),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.delete, color: Color.fromARGB(255, 157, 50, 43)),
          onPressed: _confirmDeleteRoom,
        ),
      ],
      backgroundColor: SwitchColors.steel_gray_950,
    ),
    backgroundColor: SwitchColors.steel_gray_950,
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 190), // Adiciona um espaço antes do primeiro elemento
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: SwitchColors.steel_gray_700),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                widget.roomName, // Mostrando o nome da sala
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.roomDescription, // Mostrando a descrição da sala
              style: TextStyle(
                fontSize: 14,
                color: SwitchColors.steel_gray_300,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10), // Adiciona espaço entre a descrição e a lista de switches
            Text(
              linkedSwitches.join(', '), // Exibindo os switches vinculados
              style: TextStyle(
                fontSize: 14,
                color: SwitchColors.steel_gray_300,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: _toggleRoom,
              borderRadius: BorderRadius.circular(75),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _roomOn ? Colors.blue : Colors.grey,
                    width: 4.0,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.power_settings_new,
                    size: 100,
                    color: _roomOn ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _roomOn ? 'LIGADO' : 'DESLIGADO',
              style: TextStyle(
                color: _roomOn ? Colors.blue : Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Removido a lista de switches vinculados que estava aqui
            // Adicionamos a lista de switches logo acima.
          ],
        ),
      ),
    ),
  );
}

}
