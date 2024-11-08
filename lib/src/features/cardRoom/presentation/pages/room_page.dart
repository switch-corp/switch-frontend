import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:switchfrontend/src/features/cardRoom/room.bloc.dart';
import 'package:switchfrontend/src/features/linkSwitch/presentation/pages/linkSwitch_page.dart';
import 'package:switchfrontend/src/features/listRoom/models/room.model.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class RoomPage extends StatefulWidget {
  final String roomId;

  const RoomPage({super.key, required this.roomId});

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  Room? room;
  bool _hasChanges = false;

  bool loading = false;

  void getData() async {
    setState(() {
      loading = true;
    });

    Room response = await RoomBloc.getRoom(widget.roomId);

    setState(() {
      room = response;
      _titleController = TextEditingController(text: room!.name);
      _descriptionController = TextEditingController(text: room!.description);
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    _titleController = TextEditingController(text: "");
    _descriptionController = TextEditingController(text: "");
    super.initState();
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
          roomId: room!.id,
          roomTitle: _titleController.text,
          roomDescription: _descriptionController.text,
        ),
      ),
    ).then((result) {
      getData();
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _conclude() async {
    setState(() {
      loading = true;
    });

    await RoomBloc.updateRoom(
      room!.id,
      _titleController.text,
      _descriptionController.text,
    );

    setState(() {
      loading = false;
    });
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
              style: SwitchTexts.titleBody(SwitchColors.steel_gray_100)
                  .copyWith(fontSize: 18),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    'você tem certeza que deseja excluir a room "${room!.name}"?',
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
              onPressed: () async {
                setState(() {
                  loading = true;
                });

                await RoomBloc.deleteRoom(room!.id);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
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
      resizeToAvoidBottomInset: false,
      backgroundColor: SwitchColors.steel_gray_950,
      appBar: AppBar(
        backgroundColor: SwitchColors.steel_gray_950,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Editar Room',
                style: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
                    .copyWith(fontWeight: FontWeight.bold)
                    .copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete,
                color: Color.fromARGB(255, 157, 50, 43)),
            onPressed: _confirmDeleteRoom,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: loading
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: loading
              ? [
                  const SizedBox(),
                  const Center(child: CircularProgressIndicator()),
                  const SizedBox(),
                ]
              : [
                  Center(
                    child: Text(
                      'Nome da Sala',
                      style: SwitchTexts.titleBody(SwitchColors.steel_gray_100)
                          .copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    maxLength: 20,
                    cursorColor: SwitchColors.ui_blueziness_800,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: SwitchColors.ui_blueziness_800),
                      ),
                      counterText: '${_titleController.text.length} / 20',
                      counterStyle: const TextStyle(color: Colors.white),
                    ),
                    onChanged: _onTitleChanged,
                    controller: _titleController,
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: Text(
                      'Descrição',
                      style: SwitchTexts.titleBody(SwitchColors.steel_gray_100)
                          .copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    maxLength: 60,
                    cursorColor: SwitchColors.ui_blueziness_800,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: SwitchColors.ui_blueziness_800),
                      ),
                      counterText: '${_descriptionController.text.length} / 60',
                      counterStyle: const TextStyle(color: Colors.white),
                    ),
                    onChanged: _onDescriptionChanged,
                    controller: _descriptionController,
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Switches Vinculados',
                        style:
                            SwitchTexts.titleBody(SwitchColors.steel_gray_100)
                                .copyWith(fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: _navigateToLinkSwitch,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: room!.switches!.map((switchItem) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          switchItem.name,
                                          style: SwitchTexts.titleBody(
                                              SwitchColors.steel_gray_100),
                                        ),
                                        Text(
                                          switchItem.id,
                                          style: const TextStyle(
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: _hasChanges ? _conclude : null,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
