import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';

import '../../../linkRoom/presentation/pages/linkRoom_page.dart';

class AddCode extends StatefulWidget {
  @override
  _AddCodeState createState() => _AddCodeState();
}

class _AddCodeState extends State<AddCode> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final ValueNotifier<bool> _codeFieldEmpty = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _nameFieldEmpty = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _codeMaxReached = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _codeController.addListener(() {
      if (_codeController.text.length > 25) {
        _codeController.text = _codeController.text.substring(0, 25);
        _codeController.selection = TextSelection.fromPosition(
          TextPosition(offset: _codeController.text.length),
        );
        _codeMaxReached.value = true;
      } else {
        _codeMaxReached.value = false;
      }
      _codeFieldEmpty.value = _codeController.text.isEmpty;
    });

    _nameController.addListener(() {
      _nameFieldEmpty.value = _nameController.text.isEmpty;
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _codeFieldEmpty.dispose();
    _nameFieldEmpty.dispose();
    _codeMaxReached.dispose();
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
          titleTextStyle: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Adicionar Código',
              style: SwitchTexts.titleBody(SwitchColors.steel_gray_50)
                  .copyWith(fontWeight: FontWeight.bold)
                  .copyWith(fontSize: 18)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
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
                const Spacer(flex: 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Digite o nome do Switch',
                      style: SwitchTexts.titleBody(SwitchColors.steel_gray_300),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      maxLength: 20,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'.{0,20}')),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: SwitchColors.steel_gray_700),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: SwitchColors.steel_gray_700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: SwitchColors.ui_blueziness_800),
                        ),
                        hintText: '',
                        hintStyle: TextStyle(color: SwitchColors.steel_gray_50),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      cursorColor: Colors.blue,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Digite o código do Switch',
                      style: SwitchTexts.titleBody(SwitchColors.steel_gray_300),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _codeController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: SwitchColors.steel_gray_700),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: SwitchColors.steel_gray_700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: SwitchColors.ui_blueziness_800),
                        ),
                        hintText: '',
                        hintStyle: TextStyle(color: SwitchColors.steel_gray_50),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      cursorColor: Colors.blue,
                    ),
                    const SizedBox(height: 20),
                    ValueListenableBuilder<bool>(
                      valueListenable: _codeMaxReached,
                      builder: (context, isMaxReached, child) {
                        return isMaxReached
                            ? const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Limite de 25 caracteres atingido!',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : Container();
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _codeFieldEmpty,
                            builder: (context, isCodeFieldEmpty, child) {
                              return TextButton(
                                onPressed: isCodeFieldEmpty
                                    ? null
                                    : () {
                                        _codeController.clear();
                                        _nameController.clear();
                                        _codeFieldEmpty.value = true;
                                        _nameFieldEmpty.value = true;
                                      },
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  side: BorderSide(
                                    color: isCodeFieldEmpty
                                        ? Colors.grey
                                        : Colors.blue,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                child: Text(
                                  'CANCELAR',
                                  style: TextStyle(
                                    color: isCodeFieldEmpty
                                        ? Colors.grey
                                        : Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _codeFieldEmpty,
                            builder: (context, isCodeFieldEmpty, child) {
                              return InkWell(
                                onTap: isCodeFieldEmpty || _nameFieldEmpty.value
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LinkRoom(),
                                          ),
                                        );
                                      },
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    color: isCodeFieldEmpty ||
                                            _nameFieldEmpty.value
                                        ? Colors.grey
                                        : const Color.fromRGBO(2, 79, 255, 1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'CONTINUAR',
                                    style: TextStyle(
                                      color: isCodeFieldEmpty ||
                                              _nameFieldEmpty.value
                                          ? Colors.black54
                                          : Colors.white,
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
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
