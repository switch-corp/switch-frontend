import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:switchfrontend/src/features/login/presentation/pages/signin_page.dart';
import 'package:switchfrontend/src/features/home/presentation/pages/home_page.dart';
import 'package:switchfrontend/src/features/login/presentation/widgets/custom_text_field.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/shared/widgets/clickable_text.dart';
import 'package:switchfrontend/src/shared/widgets/full-length-button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  final RegExp _emailRegex = RegExp(
    r'^[^@]+@[^@]+\.[^@]+$'
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: SwitchColors.steel_gray_950,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: SvgPicture.asset('lib/assets/switch-logo-branco.svg'),
                ),
                Center(
                  child: Text(
                    'Login',
                    style: SwitchTexts.titleSection(SwitchColors.steel_gray_100),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  mandatory: true,
                  textColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O e-mail é obrigatório';
                    } else if (!_emailRegex.hasMatch(value)) {
                      return 'Insira um e-mail válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Senha',
                  controller: _passwordController,
                  mandatory: true,
                  obscureText: true,
                  textColor: Colors.white,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'A senha deve ter pelo menos 8 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                FullLengthButton(
                  text: 'continuar',
                  onClick: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 32),
                Center(
                  child: ClickableText(
                    text: 'Não tem uma conta?\nCadastre-se',
                    onClick: () => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SigninPage(),
                        ),
                      )
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
