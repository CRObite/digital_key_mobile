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

  ReviewProfileSuccess({required this.client});
}

class ReviewProfileDraftSet extends ReviewProfileState {}
