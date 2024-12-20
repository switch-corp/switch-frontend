import 'package:flutter/material.dart';
import 'package:switchfrontend/src/features/addCode/presentation/pages/addCode_page.dart';
import 'package:switchfrontend/src/features/controlSwitch/presentation/pages/controlSwitch_page.dart';
import 'package:switchfrontend/src/features/home/presentation/pages/home_page.dart';
import 'package:switchfrontend/src/features/listSwitch/list-switch.bloc.dart';
import 'package:switchfrontend/src/features/listSwitch/models/switch.model.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class SwitchesPage extends StatefulWidget {
  const SwitchesPage({super.key});

  @override
  _SwitchesPageState createState() => _SwitchesPageState();
}

class _SwitchesPageState extends State<SwitchesPage> {
  List<SwitchModel> _switches = [];

  bool loading = false;

  void _addSwitch(String switchLabel) {
    setState(() {
      _switches.add({'label': switchLabel, 'state': 'off'} as SwitchModel);
    });
  }

  void _editSwitchName(String switchId, String oldLabel) async {
    final newLabel = await showEditDialog(oldLabel);
    if (newLabel != null && newLabel.isNotEmpty) {
      ListSwitchBloc.renameSwitch(newLabel, switchId);
    }
  }

  void getSwitches() async {
    setState(() {
      loading = true;
    });

    try {
      var response = await ListSwitchBloc.getSwitch();
      setState(() {
        _switches = response;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    getSwitches();
    super.initState();
  }

  Future<String?> showEditDialog(String currentLabel) {
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
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: const OutlineInputBorder(
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
        title: Text(
          'Switches',
          style: SwitchTexts.titleBody(SwitchColors.steel_gray_50).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: !loading
              ? Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: _switches.map((switchState) {
                          String switchLabel = switchState.name;
                          bool status = switchState.is_active;
                          String arduinoCode = switchState.arduino_id;
                          String switchId = switchState.id;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildSwitch(
                                  switchLabel, status, arduinoCode, switchId),
                              Divider(
                                  color: Colors.blueAccent.withOpacity(0.3)),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 10),
                    ListTile(
                      title: const Text(
                        'Adicionar switch',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: const Icon(Icons.add, color: Colors.white),
                      onTap: () {
                        navigateToAddSwitch(context);
                      },
                    ),
                  ],
                )
              : const SizedBox()),
    );
  }

  Widget buildSwitch(
      String switchLabel, bool status, String arduinoCode, String switchId) {
    Color iconColor;
    String displayText;
    String tooltipMessage;

    switch (status ? 'on' : 'off') {
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
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.grey[400], size: 23),
                  onPressed: () => _editSwitchName(switchId, switchLabel),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            arduinoCode,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
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
        navigateToControlSwitch(
            context, switchLabel, arduinoCode, status, switchId);
      },
    );
  }

  void navigateToControlSwitch(BuildContext context, String switchName,
      String arduinoCode, bool switchState, String switchId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ControlSwitch(
          switchName: switchName,
          arduinoCode: arduinoCode,
          switchState: switchState,
          switchId: switchId,
        ),
      ),
    );
  }

  void navigateToAddSwitch(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddCode(),
      ),
    );

    if (result != null) {
      _addSwitch(result['label']);
    }
  }
}
