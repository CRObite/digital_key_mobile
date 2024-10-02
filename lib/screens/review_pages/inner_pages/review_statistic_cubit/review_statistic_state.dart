part of 'review_statistic_cubit.dart';

@immutable
abstract class ReviewStatisticState {}

class ReviewStatisticInitial extends ReviewStatisticState {}

class ReviewStatisticLoading extends ReviewStatisticState {}

class ReviewStatisticSuccess extends ReviewStatisticState {
  final List<ClientContractService> listOfCCS;

  ReviewStatisticSuccess({required this.listOfCCS});
}
