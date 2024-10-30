import 'package:switchfrontend/src/features/login/auth.api.dart';
import 'package:switchfrontend/src/features/login/auth.states.dart';

class AuthBloc {
  static late String userToken;

  static Future<AuthState> login(String email, String password) async {
    try {
      String token = await AuthApi.login(email, password);
      if (token.isEmpty) return FailureAuthState();
      AuthBloc.userToken = token;
      return SuccessAuthState();
    } catch (e) {
      return FailureAuthState();
    }
  }

  static Future<AuthState> signUp(
      String email, String password, String username) async {
    try {
      String token = await AuthApi.signUp(email, password, username);
      if (token.isEmpty) {
        return FailureAuthState(errorMessage: "Algo deu errado...");
      }
      AuthBloc.userToken = token;
      return SuccessAuthState();
    } on Exception catch (e) {
      return FailureAuthState(errorMessage: e.toString());
    }
  }
}
