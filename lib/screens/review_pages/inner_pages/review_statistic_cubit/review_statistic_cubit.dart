

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/domain/metric_report_group.dart';

import '../../../../data/repository/client_repository.dart';
import '../../../../data/repository/contract_repository.dart';
import '../../../../data/repository/metrics_repository.dart';
import '../../../../domain/client.dart';
import '../../../../domain/client_contract_service.dart';
import '../../../../domain/pageable.dart';
import '../../../../utils/custom_exeption.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

part 'review_statistic_state.dart';

class ReviewStatisticCubit extends Cubit<ReviewStatisticState> {
  ReviewStatisticCubit() : super(ReviewStatisticInitial());

  int page = 0;
  int size = 10;
  int maxPage = 0;
  List<ClientContractService> listOfCCS = [];

  Client? client;

  Future<void> getClientData(BuildContext context,NavigationPageCubit navigationPageCubit) async {

    try{
      Client? data =  await ClientRepository.getClient(context);

      if(data!= null) {
        client = data;
      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        navigationPageCubit.showMessage(exception.message, false);
      }else{
        rethrow;
      }
    }
  }







  Future<void> getServiceData(BuildContext context,  NavigationPageCubit navigationPageCubit, {needLoading=false}) async {

    if(needLoading){
      emit(ReviewStatisticLoading());
    }

    try{
      Pageable? pageable = await ContractRepository.getContractService(context, '', page, size,clientId: client!.id);

      if(pageable!= null){
        for(var item in pageable.content){
          listOfCCS.add(ClientContractService.fromJson(item));
        }

        maxPage = pageable.totalPages;

        emit(ReviewStatisticSuccess(listOfCCS: listOfCCS));
      }
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
      }else{
        rethrow;
      }
    }
  }


  void resetList(BuildContext context, NavigationPageCubit navigationPageCubit) {
    page = 0;
    listOfCCS.clear();
    getServiceData(context, navigationPageCubit,needLoading: true);
  }
}
