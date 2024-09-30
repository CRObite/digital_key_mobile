part of 'contract_creating_cubit.dart';

@immutable
abstract class ContractCreatingState {}

class ContractCreatingInitial extends ContractCreatingState {}

class ContractCreatingDataLoading extends ContractCreatingState {}

class ContractCreatingFetchingSuccess extends ContractCreatingState {
  final List<ContractDataContainer> contractDataContainer;

  ContractCreatingFetchingSuccess({required this.contractDataContainer});
}

class ContractCreatingSuccess extends ContractCreatingState {}


