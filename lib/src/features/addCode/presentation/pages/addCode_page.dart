import 'package:flutter/material.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/features/controlSwitch/presentation/pages/controlSwitch_page.dart';

class AddCode extends StatefulWidget {
  @override
  _AddCodeState createState() => _AddCodeState();
}

class _AddCodeState extends State<AddCode> {
  TextEditingController _controller = TextEditingController();
  ValueNotifier<bool> _fieldEmpty = ValueNotifier<bool>(true);
  ValueNotifier<bool> _maxReached = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.length > 25) {
        _controller.text = _controller.text.substring(0, 25);
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
        _maxReached.value = true;
      } else {
        _maxReached.value = false;
      }
      _fieldEmpty.value = _controller.text.isEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _fieldEmpty.dispose();
    _maxReached.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: SwitchColors.steel_gray_950,
        appBarTheme: AppBarTheme(
          backgroundColor: SwitchColors.steel_gray_950,
          titleTextStyle: SwitchTexts.titleBody(SwitchColors.steel_gray_50).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Adicionar Código',
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Digite o código do Switch',
                      style: SwitchTexts.titleBody(SwitchColors.steel_gray_300),
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: _controller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: SwitchColors.steel_gray_700),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: SwitchColors.steel_gray_700),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: SwitchColors.steel_gray_700),
                          ),
                          hintText: '',
                          hintStyle: TextStyle(color: SwitchColors.steel_gray_50),
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        cursorColor: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 20),
                    ValueListenableBuilder<bool>(
                      valueListenable: _maxReached,
                      builder: (context, isMaxReached, child) {
                        return isMaxReached
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Limite de 25 caracteres atingido!',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : Container();
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _fieldEmpty,
                            builder: (context, isFieldEmpty, child) {
                              return TextButton(
                                onPressed: isFieldEmpty
                                    ? null
                                    : () {
                                        _controller.clear();
                                        _fieldEmpty.value = true;
                                      },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  side: BorderSide(
                                    color: isFieldEmpty ? Colors.grey : Colors.blue,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  'CANCELAR',
                                  style: TextStyle(
                                    color: isFieldEmpty ? Colors.grey : Colors.white,
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
                            valueListenable: _fieldEmpty,
                            builder: (context, isFieldEmpty, child) {
                              return InkWell(
                                onTap: isFieldEmpty
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ControlSwitch(switchCode: _controller.text),
                                          ),
                                        );
                                      },
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    color: isFieldEmpty ? Colors.grey : Color.fromRGBO(2, 79, 255, 1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'CONTINUAR',
                                    style: TextStyle(
                                      color: isFieldEmpty ? Colors.black54 : Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
