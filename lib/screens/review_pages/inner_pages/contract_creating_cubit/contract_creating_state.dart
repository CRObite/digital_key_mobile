part of 'contract_creating_cubit.dart';

@immutable
abstract class ContractCreatingState {}

class ContractCreatingInitial extends ContractCreatingState {}

class ContractCreatingSuccess extends ContractCreatingState {}

class ContractCreatingError extends ContractCreatingState {

  final String errorMessage;
  final bool positive;

  ContractCreatingError({required this.errorMessage, required this.positive});
}
