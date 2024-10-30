class AuthState {}

class SuccessAuthState extends AuthState {}

class FailureAuthState extends AuthState {
  String? errorMessage;

  FailureAuthState({this.errorMessage});
}
