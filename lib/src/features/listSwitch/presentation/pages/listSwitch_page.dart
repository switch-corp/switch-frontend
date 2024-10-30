import 'package:flutter/material.dart';
import 'package:switchfrontend/src/features/addCode/presentation/pages/addCode_page.dart';
import 'package:switchfrontend/src/features/controlSwitch/presentation/pages/controlSwitch_page.dart';
import 'package:switchfrontend/src/features/home/presentation/pages/home_page.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class SwitchesPage extends StatefulWidget {
  @override
  _SwitchesPageState createState() => _SwitchesPageState();
}

class _SwitchesPageState extends State<SwitchesPage> {
  final Map<String, Map<String, String>> _switchStates = {
    'Sala 1': {
      'Interruptor da frente': 'on',
      'Interruptor do meio': 'off',
      'Interruptor de trás': 'error',
      'Interruptor da frente 2': 'on',
    },
    'Room': {
      'Interruptor da frente 1': 'error',
      'Interruptor da frente 2': 'off',
      'Interruptor da frente 3': 'on',
      'Interruptor da frente 4': 'off',
    }
  };

  void _addSwitch(String room, String switchLabel) {
    setState(() {
      if (_switchStates[room] != null) {
        _switchStates[room]![switchLabel] = 'off';
      } else {
        _switchStates[room] = {switchLabel: 'off'};
      }
    });
  }

  void _editSwitchName(String room, String oldLabel) async {
    final newLabel = await _showEditDialog(oldLabel);
    if (newLabel != null && newLabel.isNotEmpty) {
      setState(() {
        _switchStates[room]![newLabel] = _switchStates[room]![oldLabel]!;
        _switchStates[room]!.remove(oldLabel);
      });
    }
  }

  Future<String?> _showEditDialog(String currentLabel) {
    TextEditingController controller =
        TextEditingController(text: currentLabel);
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: SwitchColors.steel_gray_950,
          title: Center(
            child: Text(
              'Editar Nome do Switch',
              style: SwitchTexts.bodyDefaultBold(SwitchColors.steel_gray_100)
                  .copyWith(fontSize: 18),
            ),
          ),
          content: TextField(
            controller: controller,
            style: SwitchTexts.titleBody(SwitchColors.steel_gray_100),
            cursorColor: SwitchColors.ui_blueziness_800,
            decoration: InputDecoration(
              hintText: "Novo Nome do Switch",
              hintStyle: SwitchTexts.titleBody(SwitchColors.steel_gray_500),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'cancelar',
                style:
                    SwitchTexts.bodyDefaultBold(SwitchColors.ui_blueziness_800)
                        .copyWith(fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: Text(
                'salvar',
                style:
                    SwitchTexts.bodyDefaultBold(SwitchColors.ui_blueziness_800)
                        .copyWith(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SwitchColors.steel_gray_950,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Switches',
            style: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
                .copyWith(fontWeight: FontWeight.bold)
                .copyWith(fontSize: 18)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: _switchStates.entries.map((entry) {
                  String room = entry.key;
                  Map<String, String> switches = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: switches.keys.map((switchLabel) {
                      return Column(
                        children: [
                          _buildSwitch(room, switchLabel),
                          Divider(color: Colors.grey[800], thickness: 1),
                        ],
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Adicionar switch',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.add, color: Colors.white),
              onTap: () {
                _navigateToAddSwitch(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch(String room, String switchLabel) {
    String status = _switchStates[room]![switchLabel]!;
    Color iconColor;
    String displayText;
    String tooltipMessage;
    String switchCode = "SAKSSNFC";

    switch (status) {
      case 'on':
        iconColor = Colors.green;
        displayText = 'ON';
        tooltipMessage = 'Switch está ligado';
        break;
      case 'off':
        iconColor = Colors.grey;
        displayText = 'OFF';
        tooltipMessage = 'Switch está desligado';
        break;
      case 'error':
      default:
        iconColor = Colors.red;
        displayText = '!';
        tooltipMessage = 'Status desconhecido ou falha';
        break;
    }

    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  switchLabel,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey[400], size: 23),
                  onPressed: () => _editSwitchName(room, switchLabel),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            switchCode,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            room,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
      trailing: Tooltip(
        message: tooltipMessage,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: iconColor,
              width: 2.0,
            ),
          ),
          child: Center(
            child: Text(
              displayText,
              style: TextStyle(
                color: iconColor,
                fontWeight: FontWeight.bold,
                fontSize: status == 'error' ? 16 : 12,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        _navigateToControlSwitch(context, switchLabel, switchCode);
      },
    );
  }

  void _navigateToControlSwitch(
      BuildContext context, String switchName, String switchCode) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ControlSwitch(
          switchName: switchName,
          switchCode: switchCode,
        ),
      ),
    );
  }

  void _navigateToAddSwitch(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCode(),
      ),
    );

    if (result != null) {
      _addSwitch(result['room'], result['label']);
    }
  }
}
