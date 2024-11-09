import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:switchfrontend/src/features/listRoom/listRoom.bloc.dart';
import 'package:switchfrontend/src/features/listRoom/models/room.model.dart';
import 'package:switchfrontend/src/features/listSchedule/list-schedule.bloc.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/features/listSchedule/presentation/pages/listSchedule_page.dart';

class LinkSwitchRoom extends StatefulWidget {
  final TimeOfDay timeOfDay;
  final List<bool> selectedDays;
  final String eventName;
  const LinkSwitchRoom(
      {super.key,
      required this.eventName,
      required this.selectedDays,
      required this.timeOfDay});

  @override
  _LinkSwitchRoomState createState() => _LinkSwitchRoomState();
}

class _LinkSwitchRoomState extends State<LinkSwitchRoom> {
  List<Room> rooms = [];
  bool loading = false;
  Set<String> selectedSwitches = {};
  Set<int> expandedRooms = {};

  Future<void> addSchedule() async {
    await ListScheduleBloc.createSchedule(widget.eventName, widget.timeOfDay,
        widget.selectedDays, selectedSwitches.toList());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ListSchedule(),
      ),
    );
  }

  Future<void> getRooms() async {
    setState(() {
      loading = true;
    });
    try {
      var response = await ListRoomBloc.getRooms();
      setState(() {
        rooms = response;
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
    getRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SwitchColors.steel_gray_950,
      appBar: AppBar(
        backgroundColor: SwitchColors.steel_gray_950,
        title: Padding(
          padding: const EdgeInsets.only(left: 120),
          child: Text(
            'Vincular Rooms e Switches',
            style: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
                .copyWith(fontWeight: FontWeight.bold)
                .copyWith(fontSize: 18),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                  bool allSelected = rooms[roomIndex].switches.every(
                      (switchItem) => selectedSwitches.contains(switchItem.id));

                  return ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          rooms[roomIndex].name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Checkbox(
                          value: allSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                for (var switchItem
                                    in rooms[roomIndex].switches) {
                                  selectedSwitches.add(switchItem.id);
                                }
                              } else {
                                for (var switchItem
                                    in rooms[roomIndex].switches) {
                                  selectedSwitches.remove(switchItem.id);
                                }
                              }
                            });
                          },
                          activeColor: SwitchColors.ui_blueziness_800,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      rooms[roomIndex].description,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    iconColor: SwitchColors.ui_blueziness_800,
                    children:
                        rooms[roomIndex].switches.map<Widget>((switchItem) {
                      return SwitchListTile(
                        title: Text(
                          switchItem.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          switchItem.id,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        value: selectedSwitches.contains(switchItem.id),
                        onChanged: (bool value) {
                          setState(() {
                            if (value) {
                              selectedSwitches.add(switchItem.id);
                            } else {
                              selectedSwitches.remove(switchItem.id);
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
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: SwitchColors.ui_blueziness_800),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'CANCELAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextButton(
                    onPressed: selectedSwitches.isNotEmpty
                        ? () async {
                            await addSchedule();
                          }
                        : null, // Desabilita o botão se não houver seleção
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: selectedSwitches.isNotEmpty
                          ? SwitchColors.ui_blueziness_800
                          : Colors
                              .grey, // Azul se houver seleção, cinza caso contrário
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'CONCLUIR',
                      style: TextStyle(
                        color: selectedSwitches.isNotEmpty
                            ? Colors.white
                            : Colors
                                .black, // Branco se houver seleção, preto caso contrário
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
