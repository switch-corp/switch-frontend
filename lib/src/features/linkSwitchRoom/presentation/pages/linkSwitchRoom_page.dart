import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/features/listSchedule/presentation/pages/listSchedule_page.dart';

class LinkSwitchRoom extends StatefulWidget {
  @override
  _LinkSwitchRoomState createState() => _LinkSwitchRoomState();
}

class _LinkSwitchRoomState extends State<LinkSwitchRoom> {
  List<Map<String, dynamic>> rooms = [
    {
      "title": "Sala 1",
      "description": "Sala de reunião 302",
      "switches": [
        {"code": "0iucfg7801", "name": "Switch 1"},
        {"code": "cefij979", "name": "Switch 2"},
      ],
    },
    {
      "title": "Sala 2",
      "description": "Sala da parede azul",
      "switches": [
        {"code": "dsa245gr3", "name": "Switch 3"},
        {"code": "afi45fndv", "name": "Switch 4"},
      ],
    },
  ];

  Set<String> selectedSwitches = {};
  Set<int> expandedRooms = {}; // Controla quais salas estão expandidas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SwitchColors.steel_gray_950,
      appBar: AppBar(
        backgroundColor: SwitchColors.steel_gray_950,
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            'Vincular Rooms e Switches',
            style: SwitchTexts.titleBody(SwitchColors.steel_gray_50).copyWith(fontWeight: FontWeight.bold).copyWith(fontSize: 18),
          ),
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
            Expanded(
              child: ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, roomIndex) {
                  bool isExpanded = expandedRooms.contains(roomIndex);
                  bool allSelected = rooms[roomIndex]['switches']
                      .every((switchItem) => selectedSwitches.contains(switchItem['code']));

                  return ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          rooms[roomIndex]['title'],
                          style: TextStyle(color: Colors.white),
                        ),
                        Checkbox(
                          value: allSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                rooms[roomIndex]['switches'].forEach((switchItem) {
                                  selectedSwitches.add(switchItem['code']);
                                });
                              } else {
                                rooms[roomIndex]['switches'].forEach((switchItem) {
                                  selectedSwitches.remove(switchItem['code']);
                                });
                              }
                            });
                          },
                          activeColor: SwitchColors.ui_blueziness_800,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      rooms[roomIndex]['description'],
                      style: TextStyle(color: Colors.grey),
                    ),
                    iconColor: SwitchColors.ui_blueziness_800,
                    children: rooms[roomIndex]['switches']
                        .map<Widget>((switchItem) {
                      return SwitchListTile(
                        title: Text(
                          switchItem['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '${switchItem['code']}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        value: selectedSwitches.contains(switchItem['code']),
                        onChanged: (bool value) {
                          setState(() {
                            if (value) {
                              selectedSwitches.add(switchItem['code']);
                            } else {
                              selectedSwitches.remove(switchItem['code']);
                            }
                          });
                        },
                        activeColor: SwitchColors.ui_blueziness_800,
                      );
                    }).toList(),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        if (expanded) {
                          expandedRooms.add(roomIndex);
                        } else {
                          expandedRooms.remove(roomIndex);
                        }
                      });
                    },
                  );
                },
              ),
            ),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
   Expanded(
  child: TextButton(
    onPressed: () {
      // Limpa as seleções
      setState(() {
        selectedSwitches.clear(); // Limpa todas as seleções
      });
    },
    style: TextButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 16),
      backgroundColor: Colors.transparent,
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
      child: TextButton(
        onPressed: selectedSwitches.isNotEmpty ? () {
          // Ação do botão CONTINUAR
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListSchedule(),
            ),
          );
        } : null, // Desabilita o botão se não houver seleção
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: selectedSwitches.isNotEmpty ? SwitchColors.ui_blueziness_800 : Colors.grey, // Azul se houver seleção, cinza caso contrário
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          'CONCLUIR',
          style: TextStyle(
            color: selectedSwitches.isNotEmpty ? Colors.white : Colors.black, // Branco se houver seleção, preto caso contrário
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
}
