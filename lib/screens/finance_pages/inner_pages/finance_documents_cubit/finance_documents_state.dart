part of 'finance_documents_cubit.dart';

@immutable
abstract class FinanceDocumentsState {}

class FinanceDocumentsInitial extends FinanceDocumentsState {}

class FinanceDocumentsLoading extends FinanceDocumentsState {}

class FinanceDocumentsSuccess extends FinanceDocumentsState {
  final List<dynamic> listOfValue;

  FinanceDocumentsSuccess({required this.listOfValue});
}