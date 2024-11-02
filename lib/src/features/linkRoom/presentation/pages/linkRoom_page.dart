import 'package:flutter/material.dart';
import 'package:switchfrontend/src/features/listswitch/presentation/pages/listswitch_page.dart'; // Importa a tela SwitchesPage
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class LinkRoom extends StatefulWidget {
  @override
  _LinkRoomState createState() => _LinkRoomState();
}

class _LinkRoomState extends State<LinkRoom> {
  List<Map<String, String>> rooms = [
    {"title": "Sala 1", "description": "Sala da parede rosa"},
    {"title": "Sala 2", "description": "Sala que é assim e assado"},
  ];

  List<bool> selectedRooms = [];

  @override
  void initState() {
    super.initState();
    selectedRooms = List<bool>.filled(rooms.length, false);
  }

  void _onRoomSelected(int index, bool isSelected) {
    setState(() {
      selectedRooms[index] = isSelected;
    });
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
           style: SwitchTexts.titleBody(SwitchColors.steel_gray_50).copyWith(fontWeight: FontWeight.bold).copyWith(fontSize: 18),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  return RoomCard(
                    title: rooms[index]['title']!,
                    description: rooms[index]['description']!,
                    isSelected: selectedRooms[index],
                    onSelected: (isSelected) => _onRoomSelected(index, isSelected),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SwitchesPage(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: SwitchColors.ui_blueziness_800), 
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'VINCULAR DEPOIS',
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
                    onPressed: isAnyRoomSelected
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SwitchesPage(),
                              ),
                            );
                          }
                        : null,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: isAnyRoomSelected ? SwitchColors.ui_blueziness_800 : Colors.grey, // Fundo azul se habilitado
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'CONCLUIR',
                      style: TextStyle(
                        color: isAnyRoomSelected ? Colors.white : Colors.black54,
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
            color: isSelected ? Colors.blueAccent : Colors.blueAccent.withOpacity(0.3),
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
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                description,
                style: TextStyle(color: Colors.grey, fontSize: 14),
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
