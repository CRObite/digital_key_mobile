part of 'registration_page_cubit.dart';

@immutable
abstract class RegistrationPageState {}

class RegistrationPageInitial extends RegistrationPageState {}

class RegistrationPageError extends RegistrationPageState {

  final String errorText;
  final Map<String, dynamic> filedErrors;

  RegistrationPageError(this.filedErrors,this.errorText);
}

class RegistrationPageSuccess extends RegistrationPageState {}
