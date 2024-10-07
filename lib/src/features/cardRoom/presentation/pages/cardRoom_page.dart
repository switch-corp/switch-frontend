import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:switchfrontend/src/features/linkSwitch/presentation/pages/linkSwitch_page.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class CardRoom extends StatefulWidget {
  final String title;
  final String description;

  const CardRoom({required this.title, required this.description});

  @override
  _CardRoomState createState() => _CardRoomState();
}

class _CardRoomState extends State<CardRoom> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _hasChanges = false;

  List<Map<String, String?>> _linkedSwitches = [
    {'label': 'Interruptor da sala', 'code': 'SW-001'},
    {'label': 'Luz da entrada', 'code': 'SW-002'},
    {'label': 'Ventilador', 'code': 'SW-003'},
    {'label': 'Luz do corredor', 'code': 'SW-004'},
    {'label': 'Ar-condicionado', 'code': 'SW-005'},
    {'label': 'Câmera de segurança', 'code': 'SW-006'},
    {'label': 'Aquecedor', 'code': 'SW-007'},
    {'label': 'Iluminação externa', 'code': 'SW-008'},
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _navigateToLinkSwitch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LinkSwitches(
          roomTitle: _titleController.text,
          roomDescription: _descriptionController.text,
        ),
      ),
    ).then((result) {
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _conclude() {
    Navigator.pop(context);
  }

  void _onTitleChanged(String value) {
    setState(() {
      _hasChanges = true;
    });
  }

  void _onDescriptionChanged(String value) {
    setState(() {
      _hasChanges = true;
    });
  }

  void _confirmDeleteRoom() {
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
              style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(fontSize: 18),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    'você tem certeza que deseja excluir a room "${widget.title}"?',
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
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Sala '${widget.title}' excluída.")),
                );
              },
              child: Text(
                'Excluir',
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
      backgroundColor: SwitchColors.steel_gray_950,
      appBar: AppBar(
        backgroundColor: SwitchColors.steel_gray_950,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Editar Room',
                style: SwitchTexts.titleBody(SwitchColors.steel_gray_50).copyWith(fontWeight: FontWeight.bold).copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Color.fromARGB(255, 157, 50, 43)),
            onPressed: _confirmDeleteRoom,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Nome da Sala',
                style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              maxLength: 20,
              cursorColor: SwitchColors.ui_blueziness_800,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: SwitchColors.ui_blueziness_800),
                ),
                counterText: '${_titleController.text.length} / 20',
                counterStyle: TextStyle(color: Colors.white),
              ),
              onChanged: _onTitleChanged,
              controller: _titleController,
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                'Descrição',
                style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              maxLength: 60,
              cursorColor: SwitchColors.ui_blueziness_800,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: SwitchColors.ui_blueziness_800),
                ),
                counterText: '${_descriptionController.text.length} / 60',
                counterStyle: TextStyle(color: Colors.white),
              ),
              onChanged: _onDescriptionChanged,
              controller: _descriptionController,
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Switches Vinculados',
                  style: SwitchTexts.titleBody(SwitchColors.steel_gray_100).copyWith(fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.white),
                  onPressed: _navigateToLinkSwitch,
                ),
              ],
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 10.0),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _linkedSwitches.map((switchItem) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    switchItem['label']!,
                                    style: SwitchTexts.titleBody(SwitchColors.steel_gray_100),
                                  ),
                                  if (switchItem['code'] != null)
                                    Text(
                                      switchItem['code']!,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _cancel,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(
                        color: SwitchColors.ui_blueziness_800,
                      ),
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
                    onPressed: _hasChanges ? _conclude : null,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: _hasChanges
                          ? SwitchColors.ui_blueziness_800
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'CONCLUIR',
                      style: TextStyle(
                        color: _hasChanges ? Colors.white : Colors.black,
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
