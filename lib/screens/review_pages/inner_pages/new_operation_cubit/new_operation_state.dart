part of 'new_operation_cubit.dart';

@immutable
abstract class NewOperationState {}

class NewOperationInitial extends NewOperationState {}

class NewOperationLoading extends NewOperationState {}

class NewOperationFetched extends NewOperationState {
  final Client client;

  NewOperationFetched({required this.client});
}
