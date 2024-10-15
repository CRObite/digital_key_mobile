part of 'finance_documents_cubit.dart';

@immutable
abstract class FinanceDocumentsState {}

class FinanceDocumentsInitial extends FinanceDocumentsState {}

class FinanceDocumentsLoading extends FinanceDocumentsState {}

class FinanceDocumentsSuccess extends FinanceDocumentsState {
  final List<Invoice> listOfInvoice;
  final List<ElectronicInvoice> listOfElectronicInvoice;
  final List<CompletionAct> listOfCompletionAct;

  FinanceDocumentsSuccess({required this.listOfInvoice, required this.listOfElectronicInvoice, required this.listOfCompletionAct});

}