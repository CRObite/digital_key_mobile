part of 'profile_screen_cubit.dart';

@immutable
abstract class ProfileScreenState {}

class ProfileScreenInitial extends ProfileScreenState {}

class ProfileScreenSuccess extends ProfileScreenState {
  final User user;
  final Client client;

  ProfileScreenSuccess({required this.user, required this.client});
}

class ProfileScreenLoading extends ProfileScreenState {}

class ProfileScreenError extends ProfileScreenState {
  final String errorText;

  ProfileScreenError({required this.errorText});
}
