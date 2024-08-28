part of 'login_page_cubit.dart';

@immutable
abstract class LoginPageState {}

class LoginPageInitial extends LoginPageState {}
class LoginPageError extends LoginPageState {
  final String errorText;

  LoginPageError({required this.errorText});
}
class LoginPageSuccess extends LoginPageState {
}
