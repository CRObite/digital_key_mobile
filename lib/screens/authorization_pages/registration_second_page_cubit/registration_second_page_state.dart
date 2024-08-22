part of 'registration_second_page_cubit.dart';

@immutable
abstract class RegistrationSecondPageState {}

class RegistrationSecondPageInitial extends RegistrationSecondPageState {}

class RegistrationSecondPageError extends RegistrationSecondPageState {
  final String errorText;

  RegistrationSecondPageError({required this.errorText});
}
class RegistrationSecondPageSuccess extends RegistrationSecondPageState {}
