import 'package:flutter/material.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class ControlSwitch extends StatefulWidget {
  final String switchCode;

  ControlSwitch({required this.switchCode});

  @override
  _ControlSwitchState createState() => _ControlSwitchState();
}

class _ControlSwitchState extends State<ControlSwitch> {
  bool _switchOn = false; 

  void _toggleSwitch() {
    setState(() {
      _switchOn = !_switchOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ligar/Desligar',
          style: SwitchTexts.titleBody(SwitchColors.steel_gray_50).copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: SwitchColors.steel_gray_700),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  widget.switchCode,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
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
              SizedBox(height: 20),
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
