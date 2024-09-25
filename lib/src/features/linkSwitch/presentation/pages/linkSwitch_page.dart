import 'package:flutter/material.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/features/listRoom/presentation/pages/listRoom_page.dart'; 

class LinkSwitches extends StatefulWidget {
  final String roomTitle;
  final String roomDescription;

  LinkSwitches({required this.roomTitle, required this.roomDescription});

  @override
  _LinkSwitchesState createState() => _LinkSwitchesState();
}

class _LinkSwitchesState extends State<LinkSwitches> {
  List<Map<String, String>> switches = [
    {"code": "sdfubg7854", "name": "Switch 1"},
    {"code": "00enogwh895432", "name": "Switch 2"},
    {"code": "2348ht9efgni", "name": "Switch 3"},
    {"code": "498rhcq3467mod", "name": "Interruptor azul"},
    {"code": "kr0x8yethwer9", "name": "Luminária escritório"},
    {"code": "klxdfng8439d", "name": "Ar-condicionado salão"},
    {"code": "2sre459790fd", "name": "Luzes ginásio"}
  ];

  Set<String> selectedSwitches = {};
  bool hasChanges = false;

  void _resetSelections() {
    setState(() {
      selectedSwitches.clear();
      hasChanges = false;
    });
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
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: switches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      switches[index]['name']!,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      '${switches[index]['code']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Switch(
                      value: selectedSwitches.contains(switches[index]['code']),
                      onChanged: (bool value) {
                        setState(() {
                          if (value) {
                            selectedSwitches.add(switches[index]['code']!);
                          } else {
                            selectedSwitches.remove(switches[index]['code']!);
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
                  child: TextButton(
                    onPressed: _resetSelections,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: SwitchColors.ui_blueziness_800),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'CANCELAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListRoom(),
                                  ),
                                );
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
