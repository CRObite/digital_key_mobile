part of 'new_operation_cubit.dart';

@immutable
abstract class NewOperationState {}

class NewOperationInitial extends NewOperationState {}

class NewOperationLoading extends NewOperationState {}

class NewOperationFirstStep extends NewOperationState {
  final Client client;

  NewOperationFirstStep({required this.client});

}

class NewOperationSecondStep extends NewOperationState {
  final Client client;
  final ServiceOperation operation;

  NewOperationSecondStep({required this.client, required this.operation});

}