import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:switchfrontend/src/features/linkSwitch/presentation/pages/linkSwitch_page.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

class AddRoom extends StatefulWidget {
  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  TextEditingController _roomNameController = TextEditingController();
  TextEditingController _roomDescriptionController = TextEditingController();
  ValueNotifier<bool> _isRoomNameEmpty = ValueNotifier<bool>(true);
  ValueNotifier<bool> _isRoomDescriptionEmpty = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    _roomNameController.addListener(_updateButtonState);
    _roomDescriptionController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    _roomDescriptionController.dispose();
    _isRoomNameEmpty.dispose();
    _isRoomDescriptionEmpty.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    _isRoomNameEmpty.value = _roomNameController.text.isEmpty;
    _isRoomDescriptionEmpty.value = _roomDescriptionController.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: SwitchColors.steel_gray_950,
        appBarTheme: AppBarTheme(
          backgroundColor: SwitchColors.steel_gray_950,
          titleTextStyle: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Adicionar Room', style: SwitchTexts.titleBody(SwitchColors.steel_gray_50).copyWith(fontWeight: FontWeight.bold).copyWith(fontSize: 18)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Digite o nome da Room',
                  style: SwitchTexts.titleBody(SwitchColors.steel_gray_300),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _roomNameController,
                  textAlign: TextAlign.center,
                  maxLength: 20,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'.{0,20}')),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: SwitchColors.steel_gray_700),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SwitchColors.steel_gray_700),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SwitchColors.ui_blueziness_800),
                    ),
                    hintStyle: TextStyle(color: SwitchColors.steel_gray_50),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  cursorColor: Colors.blue,
                ),
                SizedBox(height: 20),
                Text(
                  'Digite a descrição da Room',
                  style: SwitchTexts.titleBody(SwitchColors.steel_gray_300),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _roomDescriptionController,
                  textAlign: TextAlign.center,
                  maxLength: 60,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'.{0,60}')),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: SwitchColors.steel_gray_700),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SwitchColors.steel_gray_700),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SwitchColors.ui_blueziness_800),
                    ),
                    hintStyle: TextStyle(color: SwitchColors.steel_gray_50),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  cursorColor: Colors.blue,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _isRoomNameEmpty,
                        builder: (context, isRoomNameEmpty, child) {
                          return TextButton(
                            onPressed: isRoomNameEmpty
                                ? null
                                : () {
                                    _roomNameController.clear();
                                    _roomDescriptionController.clear();
                                    _isRoomNameEmpty.value = true;
                                    _isRoomDescriptionEmpty.value = true;
                                    Navigator.pop(context); 
                                  },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(
                                color: isRoomNameEmpty ? Colors.grey : Colors.blue,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              'CANCELAR',
                              style: TextStyle(
                                color: isRoomNameEmpty ? Colors.grey : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _isRoomNameEmpty,
                        builder: (context, isRoomNameEmpty, child) {
                          return ValueListenableBuilder<bool>(
                            valueListenable: _isRoomDescriptionEmpty,
                            builder: (context, isRoomDescriptionEmpty, child) {
                              return InkWell(
                                onTap: isRoomNameEmpty || isRoomDescriptionEmpty
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LinkSwitches(
                                              roomTitle: _roomNameController.text,
                                              roomDescription: _roomDescriptionController.text,
                                            ),
                                          ),
                                        );
                                      },
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    color: isRoomNameEmpty || isRoomDescriptionEmpty
                                        ? Colors.grey
                                        : Color.fromRGBO(2, 79, 255, 1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'CONTINUAR',
                                    style: TextStyle(
                                      color: isRoomNameEmpty || isRoomDescriptionEmpty
                                          ? Colors.black54
                                          : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
