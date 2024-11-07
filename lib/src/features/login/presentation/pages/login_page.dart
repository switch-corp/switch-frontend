import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:switchfrontend/src/features/login/auth.bloc.dart';
import 'package:switchfrontend/src/features/login/presentation/pages/signin_page.dart';
import 'package:switchfrontend/src/features/home/presentation/pages/home_page.dart';
import 'package:switchfrontend/src/features/login/presentation/widgets/custom_text_field.dart';
import 'package:switchfrontend/src/shared/enums/switch_colors.dart';
import 'package:switchfrontend/src/shared/enums/switch_texts.dart';
import 'package:switchfrontend/src/shared/widgets/clickable_text.dart';
import 'package:switchfrontend/src/shared/widgets/full-length-button.dart';
import 'package:switchfrontend/src/features/login/auth.states.dart';
import 'package:switchfrontend/src/features/splash_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isAuthError = false;

  final RegExp _emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

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
              crossAxisAlignment: isLoading
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: isLoading
                  ? [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 32,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ]
                  : [
                      const SizedBox(height: 20),
                      Center(
                        child: SvgPicture.asset(
                            'lib/assets/switch-logo-branco.svg'),
                      ),
                      Center(
                        child: Text(
                          'Login',
                          style: SwitchTexts.titleSection(
                              SwitchColors.steel_gray_100),
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
                      if (isAuthError)
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Login ou senha incorretos",
                            style: TextStyle(
                              color: Colors.red, // Cor vermelha
                              fontSize: 14,
                            ),
                          ),
                        ),
                      const SizedBox(height: 32),
                      FullLengthButton(
                        text: 'continuar',
                        onClick: () async {
                          if (_formKey.currentState?.validate() == true) {
                            setState(() {
                              isLoading = true;
                            });

                            AuthState state = await AuthBloc.login(
                              _emailController.text,
                              _passwordController.text,
                            );

                            if (state is FailureAuthState) {
                              setState(() {
                                isLoading = false;
                                isAuthError = true;
                              });
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SplashScreen(isPostAuth: true),
                                ),
                              );
                            }
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
