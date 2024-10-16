import 'package:flutter/material.dart';
import 'package:switchfrontend/src/features/addCode/presentation/pages/addCode_page.dart';
import 'package:switchfrontend/src/features/controlSwitch/presentation/pages/controlswitch_page.dart';
import 'package:switchfrontend/src/features/home/presentation/pages/home_page.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class SwitchesPage extends StatefulWidget {
  @override
  _SwitchesPageState createState() => _SwitchesPageState();
}

class _SwitchesPageState extends State<SwitchesPage> {
  List<Map<String, String>> _switchStates = [
    {'label': 'Interruptor da frente', 'state': 'on'},
    {'label': 'Interruptor do meio', 'state': 'off'},
    {'label': 'Interruptor de trás', 'state': 'error'},
    {'label': 'Interruptor da frente 2', 'state': 'on'},
    {'label': 'Interruptor da cozinha', 'state': 'on'},
    {'label': 'Interruptor do quintal', 'state': 'off'},
    {'label': 'Interruptor de trás', 'state': 'error'},
    {'label': 'Interruptor da frente 2', 'state': 'on'},
   {'label': 'Interruptor novo', 'state': 'on'},
    {'label': 'Interruptor quarto térreo', 'state': 'off'},
    {'label': 'Interruptor de trás', 'state': 'error'},
    {'label': 'Interruptor da frente 5', 'state': 'on'}
  ];

  void _addSwitch(String switchLabel) {
    setState(() {
      _switchStates.add({'label': switchLabel, 'state': 'off'});
    });
  }

  void _editSwitchName(String oldLabel) async {
    final newLabel = await _showEditDialog(oldLabel);
    if (newLabel != null && newLabel.isNotEmpty) {
      setState(() {
        int index = _switchStates.indexWhere((switchState) => switchState['label'] == oldLabel);
        if (index != -1) {
          _switchStates[index]['label'] = newLabel;
        }
      });
    }
  }

  Future<String?> _showEditDialog(String currentLabel) {
    TextEditingController controller = TextEditingController(text: currentLabel);
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
                style: SwitchTexts.bodyDefaultBold(SwitchColors.ui_blueziness_800)
                    .copyWith(fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: Text(
                'salvar',
                style: SwitchTexts.bodyDefaultBold(SwitchColors.ui_blueziness_800)
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
        title: Text(
          'Switches',
          style: SwitchTexts.titleBody(SwitchColors.steel_gray_50).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
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
                children: _switchStates.map((switchState) {
                  String switchLabel = switchState['label']!;
                  String status = switchState['state']!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSwitch(switchLabel, status),
                      Divider(color: Colors.blueAccent.withOpacity(0.3)),
                    ],
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

  Widget _buildSwitch(String switchLabel, String status) {
    Color iconColor;
    String displayText;
    String tooltipMessage;
    String switchCode = "SAKSSNFC";

    switch (status) {
      case 'on':
        iconColor = Colors.blue; // Mudou a cor para azul
        displayText = 'ON';
        tooltipMessage = 'Switch está ligado';
        break;
      case 'off':
        iconColor = Colors.grey; // Mantido cinza
        displayText = 'OFF';
        tooltipMessage = 'Switch está desligado';
        break;
      case 'error':
      default:
        iconColor = Colors.red; // Mantido vermelho para erro
        displayText = '!'; // Indicação de erro
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
                  onPressed: () => _editSwitchName(switchLabel),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            switchCode,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
      trailing: Tooltip(
        message: tooltipMessage,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: iconColor.withOpacity(0.1), // Fundo leve para visualização
          ),
          child: Center(
            child: Text(
              displayText,
              style: TextStyle(
                color: iconColor,
                fontWeight: FontWeight.bold,
                fontSize: status == 'error' ? 14 : 12,
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

  void _navigateToControlSwitch(BuildContext context, String switchName, String switchCode) {
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
      _addSwitch(result['label']);
    }
  }
}
