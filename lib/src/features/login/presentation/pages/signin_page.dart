import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:switchfrontend/src/features/login/presentation/pages/login_page.dart';
import 'package:switchfrontend/src/features/login/presentation/widgets/custom_text_field.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/shared/widgets/clickable_text.dart';
import 'package:switchfrontend/src/shared/widgets/full-length-button.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: SwitchColors.steel_gray_950,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: SvgPicture.asset('lib/assets/switch-logo-branco.svg'),
              ),
              Center(
                child: Text(
                  'Cadastro',
                  style: SwitchTexts.titleSection(SwitchColors.steel_gray_100),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'Nome',
                controller: _usernameController,
                mandatory: true,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                label: 'Email',
                controller: _emailController,
                mandatory: true,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                label: 'Senha',
                controller: _passwordController,
                mandatory: true,
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                label: 'Confirmar senha',
                controller: _confirmPasswordController,
                mandatory: true,
                obscureText: true,
              ),
              const SizedBox(height: 32),
              FullLengthButton(
                text: 'continuar',
                onClick: () {},
              ),
              const SizedBox(height: 32),
              Center(
                child: ClickableText(
                  text: 'Já tem uma conta?\nFaça login',
                  onClick: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    )
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
