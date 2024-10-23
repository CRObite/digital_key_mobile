

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/data/repository/documents_repository.dart';
import 'package:web_com/domain/client.dart';
import 'package:web_com/domain/completion_act.dart';
import 'package:web_com/domain/electronic_invoice.dart';

import '../../../../data/repository/client_repository.dart';
import '../../../../domain/invoice.dart';
import '../../../../domain/pageable.dart';
import '../../../../utils/custom_exeption.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

part 'finance_documents_state.dart';

class FinanceDocumentsCubit extends Cubit<FinanceDocumentsState> {
  FinanceDocumentsCubit() : super(FinanceDocumentsInitial());

  int page = 0;
  int size = 10;
  int maxPage = 0;


  List<Invoice> listOfInvoice = [];
  List<ElectronicInvoice> listOfElectronicInvoice = [];
  List<CompletionAct> listOfCompletionAct = [];

  Client? client;


  Future<void> getClient(NavigationPageCubit navigationPageCubit,BuildContext context) async {
    try {
      client = await ClientRepository.getClient(context);
    } catch (e) {
      if (e is DioException) {
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
      } else {
        rethrow;
      }
    }
  }

  Future<void> getInvoices(BuildContext context,NavigationPageCubit navigationPageCubit, {needLoading=false,String? status,String? fromDate,String? toDate,String? fromAmount,String? toAmount,}) async {

    if(needLoading){
      emit(FinanceDocumentsLoading());
    }

    try{
      if(client!= null){
        Pageable? pageable = await DocumentsRepository.getInvoices(context, page, size,client!.id!,status: status,fromDate: fromDate,toDate: toDate,fromAmount: fromAmount,toAmount: toAmount);

        if(pageable!= null){

          for(var item in pageable.content){
            listOfInvoice.add(Invoice.fromJson(item));
          }

          maxPage = pageable.totalPages;
          emit(FinanceDocumentsSuccess(listOfInvoice: listOfInvoice, listOfElectronicInvoice: listOfElectronicInvoice, listOfCompletionAct: listOfCompletionAct));
        }else{
          emit(FinanceDocumentsSuccess(listOfInvoice: listOfInvoice, listOfElectronicInvoice: listOfElectronicInvoice, listOfCompletionAct: listOfCompletionAct));
        }
      }
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
        emit(FinanceDocumentsSuccess(listOfInvoice: listOfInvoice, listOfElectronicInvoice: listOfElectronicInvoice, listOfCompletionAct: listOfCompletionAct));
      }else{
        rethrow;
      }
    }
  }

  Future<void> getElectronicInvoices(BuildContext context,NavigationPageCubit navigationPageCubit, {needLoading=false,String? status,String? fromDate,String? toDate,String? fromAmount,String? toAmount,}) async {

    if(needLoading){
      emit(FinanceDocumentsLoading());
    }

    try{

      if(client!= null){
        Pageable? pageable = await DocumentsRepository.getElectronicInvoices(context, page, size,client!.id!,status: status,fromDate: fromDate,toDate: toDate,fromAmount: fromAmount,toAmount: toAmount);

        if(pageable!= null){

          for(var item in pageable.content){
            listOfElectronicInvoice.add(ElectronicInvoice.fromJson(item));
          }

          maxPage = pageable.totalPages;
          emit(FinanceDocumentsSuccess(listOfInvoice: listOfInvoice, listOfElectronicInvoice: listOfElectronicInvoice, listOfCompletionAct: listOfCompletionAct));
        }else{
          emit(FinanceDocumentsSuccess(listOfInvoice: listOfInvoice, listOfElectronicInvoice: listOfElectronicInvoice, listOfCompletionAct: listOfCompletionAct));
        }
      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
        emit(FinanceDocumentsSuccess(listOfInvoice: listOfInvoice, listOfElectronicInvoice: listOfElectronicInvoice, listOfCompletionAct: listOfCompletionAct));
      }else{
        rethrow;
      }
    }
  }

  Future<void> getCompletionActs(BuildContext context,NavigationPageCubit navigationPageCubit, {needLoading=false,String? status,String? fromDate,String? toDate,String? fromAmount,String? toAmount,}) async {

    if(needLoading){
      emit(FinanceDocumentsLoading());
    }

    try{

      if(client != null){
        Pageable? pageable = await DocumentsRepository.getCompletionActs(context, page, size,client!.id!,status: status,fromDate: fromDate,toDate: toDate,fromAmount: fromAmount,toAmount: toAmount);

        if(pageable!= null){

          for(var item in pageable.content){
            listOfCompletionAct.add(CompletionAct.fromJson(item));
          }

          maxPage = pageable.totalPages;
          emit(FinanceDocumentsSuccess(listOfInvoice: listOfInvoice, listOfElectronicInvoice: listOfElectronicInvoice, listOfCompletionAct: listOfCompletionAct));
        }else{
          emit(FinanceDocumentsSuccess(listOfInvoice: listOfInvoice, listOfElectronicInvoice: listOfElectronicInvoice, listOfCompletionAct: listOfCompletionAct));
        }
      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
        emit(FinanceDocumentsSuccess(listOfInvoice: listOfInvoice, listOfElectronicInvoice: listOfElectronicInvoice, listOfCompletionAct: listOfCompletionAct));
      }else{
        rethrow;
      }
    }
  }


  void resetInvoiceList(BuildContext context, NavigationPageCubit navigationPageCubit,{String? status,String? fromDate,String? toDate,String? fromAmount,String? toAmount,}) {
    page = 0;
    listOfInvoice.clear();
    getInvoices(context, navigationPageCubit,needLoading: true,status: status,fromDate: fromDate,toDate: toDate,fromAmount: fromAmount,toAmount: toAmount);
  }

  void resetElectronicInvoiceList(BuildContext context, NavigationPageCubit navigationPageCubit,{String? status,String? fromDate,String? toDate,String? fromAmount,String? toAmount,}) {
    page = 0;
    listOfElectronicInvoice.clear();
    getElectronicInvoices(context, navigationPageCubit,needLoading: true,status: status,fromDate: fromDate,toDate: toDate,fromAmount: fromAmount,toAmount: toAmount);
  }

  void resetCompletionActsList(BuildContext context, NavigationPageCubit navigationPageCubit,{String? status,String? fromDate,String? toDate,String? fromAmount,String? toAmount,}) {
    page = 0;
    listOfCompletionAct.clear();
    getCompletionActs(context, navigationPageCubit,needLoading: true,status: status,fromDate: fromDate,toDate: toDate,fromAmount: fromAmount,toAmount: toAmount);
  }




}
