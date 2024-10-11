part of 'review_profile_cubit.dart';

@immutable
abstract class ReviewProfileState {}

class ReviewProfileInitial extends ReviewProfileState {}

class ReviewProfileError extends ReviewProfileState {
  final String errorText;

  ReviewProfileError({required this.errorText});
}

class ReviewProfileSuccess extends ReviewProfileState {
  final Client client;
  final Map<String,dynamic>? fieldErrors;

  ReviewProfileSuccess({required this.client,this.fieldErrors});
}

class ReviewProfileLoading extends ReviewProfileState {}
