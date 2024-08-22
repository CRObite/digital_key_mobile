part of 'password_recovery_cubit.dart';

@immutable
abstract class PasswordRecoveryState {}

class PasswordRecoveryInitial extends PasswordRecoveryState {}

class PasswordRecoveryError extends PasswordRecoveryState {
  final String errorText;

  PasswordRecoveryError({required this.errorText});
}
class PasswordRecoverySuccess extends PasswordRecoveryState {}
