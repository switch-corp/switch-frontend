import 'package:flutter/material.dart';
import 'package:switchfrontend/src/features/addRoom/presentation/pages/addRoom_page.dart';
import 'package:switchfrontend/src/features/listRoom/listRoom.bloc.dart';
import 'package:switchfrontend/src/features/listRoom/models/room.model.dart';
import 'package:switchfrontend/src/features/listSwitch/presentation/pages/listSwitch_page.dart';
import 'package:switchfrontend/src/features/cardRoom/presentation/pages/cardRoom_page.dart';
import 'package:switchfrontend/src/features/home/presentation/pages/home_page.dart';
import 'package:switchfrontend/src/features/controlRoom/presentation/pages/controlRoom_page.dart'; // Adicione a importação para ControlRoom
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class ListRoom extends StatefulWidget {
  @override
  _ListRoomState createState() => _ListRoomState();
}

class _ListRoomState extends State<ListRoom> {
  List<Room> rooms = [];

  bool loading = false;

  void _addRoom() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddRoom()),
    );

    if (result != null) {
      final roomData = result as Map<String, String>;
      setState(() {
        rooms.add(new Room(
          id: "",
          name: roomData['title']!,
          description: roomData['description']!,
        ));
      });
    }
  }

  void _getRooms() async {
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

  void _navigateToCardRoom(String roomTitle, String roomDescription) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardRoom(
          title: roomTitle,
          description: roomDescription,
        ),
      ),
    );
  }

  void _navigateToControlRoom(String roomTitle, String roomDescription) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ControlRoom(
          roomName: roomTitle,
          roomDescription: roomDescription,
        ),
      ),
    );
  }

  @override
  void initState() {
    _getRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SwitchColors.steel_gray_950, // Cor de fundo da tela
      appBar: AppBar(
        backgroundColor: SwitchColors.steel_gray_950,
        title: Padding(
          padding: const EdgeInsets.only(left: 110.0),
          child: Text(
            'Rooms',
            style: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
                .copyWith(fontWeight: FontWeight.bold)
                .copyWith(fontSize: 18),
          ),
        ),
leading: IconButton(
  icon: Icon(Icons.arrow_back, color: Colors.grey[400]),
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
          mainAxisAlignment:
              loading ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: loading
              ? [
                  const Center(child: CircularProgressIndicator()),
                ]
              : [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        return RoomCard(
                          title: rooms[index].name,
                          description: rooms[index].description,
                          onEdit: () => _navigateToCardRoom(
                            rooms[index].name,
                            rooms[index].description,
                          ),
                        );
                      },
                    ),
                    onTap: () => _navigateToControlRoom(
                      rooms[index]['title']!,
                      rooms[index]['description']!,
                    ), // Adiciona o evento onTap para navegação
                  );
              ),
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text(
                'Adicionar room',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.add, color: Colors.white),
              onTap: _addRoom,
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
  final VoidCallback onEdit;
  final VoidCallback onTap; // Adiciona o callback onTap

  const RoomCard({
    required this.title,
    required this.description,
    required this.onEdit,
    required this.onTap, // Adiciona o parâmetro onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Adiciona a navegação ao clicar no card
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Fundo transparente
          border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey[400], size: 23),
                    onPressed: onEdit,
                  ),
                ],
              ),
              Text(
                description,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
