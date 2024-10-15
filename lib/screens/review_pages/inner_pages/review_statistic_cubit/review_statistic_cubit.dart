

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

  Client? client;

  Future<void> getClientData(BuildContext context,NavigationPageCubit navigationPageCubit) async {
    try{
      client =  await ClientRepository.getClient(context);
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
      }else{
        rethrow;
      }
    }
  }






}
