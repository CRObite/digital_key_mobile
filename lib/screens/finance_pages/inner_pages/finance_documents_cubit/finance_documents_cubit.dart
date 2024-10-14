

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/data/repository/documents_repository.dart';

import '../../../../domain/pageable.dart';
import '../../../../utils/custom_exeption.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

part 'finance_documents_state.dart';

class FinanceDocumentsCubit extends Cubit<FinanceDocumentsState> {
  FinanceDocumentsCubit() : super(FinanceDocumentsInitial());

  int page = 0;
  int size = 10;
  int maxPage = 0;
  List<dynamic> listOfValue = [];


  Future<void> getInvoices(BuildContext context,NavigationPageCubit navigationPageCubit, {needLoading=false}) async {

    if(needLoading){
      emit(FinanceDocumentsLoading());
    }

    try{
      Pageable? pageable = await DocumentsRepository.getInvoices(context, page, size);

      if(pageable!= null){

        listOfValue = pageable.content;

        maxPage = pageable.totalPages;
        emit(FinanceDocumentsSuccess(listOfValue: listOfValue));
      }else{
        emit(FinanceDocumentsSuccess(listOfValue: const []));
      }
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
        emit(FinanceDocumentsSuccess(listOfValue: const []));
      }else{
        rethrow;
      }
    }
  }

  Future<void> getElectronicInvoices(BuildContext context,NavigationPageCubit navigationPageCubit, {needLoading=false}) async {

    if(needLoading){
      emit(FinanceDocumentsLoading());
    }

    try{
      Pageable? pageable = await DocumentsRepository.getElectronicInvoices(context, page, size);

      if(pageable!= null){

        listOfValue = pageable.content;

        maxPage = pageable.totalPages;
        emit(FinanceDocumentsSuccess(listOfValue: listOfValue));
      }else{
        emit(FinanceDocumentsSuccess(listOfValue: const []));
      }
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
        emit(FinanceDocumentsSuccess(listOfValue: const []));
      }else{
        rethrow;
      }
    }
  }

  Future<void> getCompletionActs(BuildContext context,NavigationPageCubit navigationPageCubit, {needLoading=false}) async {

    if(needLoading){
      emit(FinanceDocumentsLoading());
    }

    try{
      Pageable? pageable = await DocumentsRepository.getCompletionActs(context, page, size);

      if(pageable!= null){

        listOfValue = pageable.content;

        maxPage = pageable.totalPages;
        emit(FinanceDocumentsSuccess(listOfValue: listOfValue));
      }else{
        emit(FinanceDocumentsSuccess(listOfValue: const []));
      }
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
        emit(FinanceDocumentsSuccess(listOfValue: const []));
      }else{
        rethrow;
      }
    }
  }


  void resetInvoiceList(BuildContext context, NavigationPageCubit navigationPageCubit) {
    page = 0;
    listOfValue.clear();
    getInvoices(context, navigationPageCubit,needLoading: true);
  }

  void resetElectronicInvoiceList(BuildContext context, NavigationPageCubit navigationPageCubit) {
    page = 0;
    listOfValue.clear();
    getElectronicInvoices(context, navigationPageCubit,needLoading: true);
  }

  void resetCompletionActsList(BuildContext context, NavigationPageCubit navigationPageCubit) {
    page = 0;
    listOfValue.clear();
    getCompletionActs(context, navigationPageCubit,needLoading: true);
  }

}
