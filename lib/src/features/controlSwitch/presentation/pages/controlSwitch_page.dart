import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:switchfrontend/src/features/controlSwitch/control-switch.api.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/features/listSwitch/presentation/pages/listSwitch_page.dart';
import 'package:http/http.dart' as http;

class ControlSwitch extends StatefulWidget {
  final String switchCode;
  final String switchName;
  final bool switchState;

  const ControlSwitch(
      {super.key,
      required this.switchCode,
      required this.switchName,
      required this.switchState});

  @override
  _ControlSwitchState createState() => _ControlSwitchState();
}

class _ControlSwitchState extends State<ControlSwitch> {
  bool _switchOn = false;
  String _arduinoId = '';

  @override
  void initState() {
    _switchOn = widget.switchState;
    _arduinoId = widget.switchCode;
    super.initState();
  }

  void _toggleSwitch() async {
    setState(() {
      _switchOn = !_switchOn;
    });

    ControlSwitchApi.powerSwitch(_arduinoId, _switchOn);
  }

  void _confirmDeleteSwitch() {
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
                    'você tem certeza que deseja excluir o switch "${widget.switchName}"?',
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
                'cancelar',
                style: SwitchTexts.titleBody(SwitchColors.ui_blueziness_800),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SwitchesPage()),
                  (route) => false,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Switch '${widget.switchName}' excluído.")),
                );
              },
              child: Text(
                'excluir',
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ligar/Desligar',
          style: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
              .copyWith(fontWeight: FontWeight.bold)
              .copyWith(fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete,
                color: Color.fromARGB(255, 157, 50, 43)),
            onPressed: _confirmDeleteSwitch,
          ),
        ],
        backgroundColor: SwitchColors.steel_gray_950,
      ),
      backgroundColor: SwitchColors.steel_gray_950,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: SwitchColors.steel_gray_700),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  widget.switchName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.switchCode,
                style: TextStyle(
                  fontSize: 14,
                  color: SwitchColors.steel_gray_300,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: _toggleSwitch,
                borderRadius: BorderRadius.circular(75),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _switchOn ? Colors.blue : Colors.grey,
                      width: 4.0,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.power_settings_new,
                      size: 100,
                      color: _switchOn ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _switchOn ? 'LIGADO' : 'DESLIGADO',
                style: TextStyle(
                  color: _switchOn ? Colors.blue : Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
