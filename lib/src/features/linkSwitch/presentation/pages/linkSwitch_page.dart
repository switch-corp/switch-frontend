import 'package:flutter/material.dart';
import 'package:switchfrontend/src/features/linkSwitch/linkSwitch.bloc.dart';
import 'package:switchfrontend/src/features/listSwitch/list-switch.bloc.dart';
import 'package:switchfrontend/src/features/listSwitch/models/switch.model.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/features/listRoom/presentation/pages/listRoom_page.dart';

class LinkSwitches extends StatefulWidget {
  final String roomId;
  final String roomTitle;
  final String roomDescription;

  LinkSwitches(
      {required this.roomId,
      required this.roomTitle,
      required this.roomDescription});

  @override
  _LinkSwitchesState createState() => _LinkSwitchesState();
}

class _LinkSwitchesState extends State<LinkSwitches> {
  List<SwitchModel> switches = [];

  bool loading = false;

  Set<String> selectedSwitches = {};
  bool hasChanges = false;

  void _resetSelections() {
    setState(() {
      selectedSwitches.clear();
      hasChanges = false;
    });
  }

  Future<void> updateSwitches() async {
    await LinkSwitchBloc.updateSwitches(
      widget.roomId,
      selectedSwitches.toList(),
    );
  }

  void getSwitches() async {
    setState(() {
      loading = true;
    });

    List<SwitchModel> lista = await ListSwitchBloc.getSwitch();

    setState(() {
      switches = lista;
      loading = false;
    });
  }

  @override
  void initState() {
    getSwitches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SwitchColors.steel_gray_950,
      appBar: AppBar(
        backgroundColor: SwitchColors.steel_gray_950,
        centerTitle: true,
        title: Text(
          'Vincular Switches à Room',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: loading
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: loading
              ? [
                  const SizedBox(),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  const SizedBox(),
                ]
              : [
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: switches.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            switches[index].name,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            '${switches[index].arduino_id}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          trailing: Switch(
                            value:
                                selectedSwitches.contains(switches[index].id),
                            onChanged: (bool value) {
                              setState(() {
                                if (selectedSwitches
                                    .contains(switches[index].id)) {
                                  selectedSwitches.remove(switches[index].id);
                                } else {
                                  selectedSwitches.add(switches[index].id);
                                }
                                hasChanges = selectedSwitches.isNotEmpty;
                              });
                            },
                            activeColor: SwitchColors.ui_blueziness_800,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey.withOpacity(0.5),
                          ),
                          tileColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            if (hasChanges) {
                              setState(() {
                                loading = true;
                              });

                              await updateSwitches();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListRoom(),
                                ),
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: hasChanges
                                  ? Color.fromRGBO(2, 79, 255, 1)
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'CONCLUIR',
                              style: TextStyle(
                                color: hasChanges ? Colors.white : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
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
}
