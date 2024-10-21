part of 'review_office_cubit.dart';

@immutable
abstract class ReviewOfficeState {}

class ReviewOfficeInitial extends ReviewOfficeState {}

class ReviewOfficeLoading extends ReviewOfficeState {}

class ReviewOfficeSuccess extends ReviewOfficeState {
  final List<ClientContractService> listOfCCS;

  ReviewOfficeSuccess({required this.listOfCCS});
}

class ReviewOfficeOperationSuccess extends ReviewOfficeState {
  final List<ServiceOperation> listOfOperations;

  ReviewOfficeOperationSuccess({required this.listOfOperations});
}
