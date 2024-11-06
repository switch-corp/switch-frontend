import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:switchfrontend/src/features/home/presentation/pages/home_page.dart';
import 'package:switchfrontend/src/features/login/presentation/pages/login_page.dart'; // Importe a LoginPage
import 'package:switchfrontend/src/features/login/presentation/pages/signin_page.dart'; // Importe a SigninPage

class SplashScreen extends StatefulWidget {
  final bool isPostAuth; // Se for true, após login ou cadastro, vai para a HomePage
  SplashScreen({this.isPostAuth = false});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(Duration(seconds: 3)); // Delay para simular o carregamento

    // Se for a splash após login/cadastro, vai para a HomePage
    if (widget.isPostAuth) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(), // Navega para a HomePage
        ),
      );
    } else {
      // Se for a splash inicial, vai para a LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(), // Navega para a tela de login
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('lib/assets/switch-logo-branco.svg', height: 100), // Logo
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white), // Indicador de carregamento
          ],
        ),
      ),
    );
  }
}
