import 'package:flutter/material.dart';
import 'package:switchfrontend/src/features/listRoom/listRoom.bloc.dart';
import 'package:switchfrontend/src/features/listRoom/models/room.model.dart';
import 'package:switchfrontend/src/features/listSwitch/presentation/list-switch.api.dart';
import 'package:switchfrontend/src/features/listSwitch/presentation/pages/listSwitch_page.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class LinkRoom extends StatefulWidget {
  final String switchCode;
  final String switchName;

  const LinkRoom(
      {super.key, required this.switchCode, required this.switchName});

  @override
  _LinkRoomState createState() => _LinkRoomState();
}

class _LinkRoomState extends State<LinkRoom> {
  bool loading = false;
  String _switchCode = '';
  String _switchName = '';
  List<Room> _rooms = [];

  List<bool> selectedRooms = [];

  void getRooms() async {
    setState(() {
      loading = true;
    });

    try {
      var response = await ListRoomBloc.getRooms();
      setState(() {
        _rooms = response;
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
    _switchCode = widget.switchCode;
    _switchName = widget.switchName;
    getRooms();
    super.initState();
    selectedRooms = List<bool>.filled(_rooms.length, false);
  }

  void _onRoomSelected(int index, bool isSelected) {
    setState(() {
      selectedRooms[index] = isSelected;
    });
  }

  void _onAddRoom(String name, String arduinoId) {
    ListSwitchApi.addSwitch(name, arduinoId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SwitchesPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAnyRoomSelected = selectedRooms.contains(true);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            'Vincular o Switch à Room',
            style: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
                .copyWith(fontWeight: FontWeight.bold)
                .copyWith(fontSize: 18),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: _rooms.length,
                itemBuilder: (context, index) {
                  return RoomCard(
                    title: _rooms[index].name,
                    description: _rooms[index].description,
                    isSelected: selectedRooms.isNotEmpty
                        ? (selectedRooms[index] == true ? true : false)
                        : false,
                    onSelected: (isSelected) =>
                        _onRoomSelected(index, isSelected),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _onAddRoom(_switchName, _switchCode),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: SwitchColors.ui_blueziness_800),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'VINCULAR DEPOIS',
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
                    onPressed: () => _onAddRoom(_switchName, _switchCode),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: isAnyRoomSelected
                          ? SwitchColors.ui_blueziness_800
                          : Colors.grey, // Fundo azul se habilitado
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'CONCLUIR',
                      style: TextStyle(
                        color:
                            isAnyRoomSelected ? Colors.white : Colors.black54,
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

class RoomCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const RoomCard({
    super.key,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(!isSelected),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: isSelected
                ? Colors.blueAccent
                : Colors.blueAccent.withOpacity(0.3),
            width: isSelected ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                description,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Switch(
                value: isSelected,
                onChanged: (value) => onSelected(value),
                activeColor: SwitchColors.ui_blueziness_800,
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
