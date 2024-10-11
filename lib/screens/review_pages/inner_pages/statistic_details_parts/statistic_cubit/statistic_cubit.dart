
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/domain/client_contract_service.dart';
import 'package:web_com/domain/metric_report_group.dart';

import '../../../../../domain/service.dart';
import '../../../../../utils/custom_exeption.dart';
import '../../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

part 'statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  StatisticCubit() : super(StatisticInitial());

  Future<void> getAllData(BuildContext context, NavigationPageCubit navigationPageCubit) async {
    try{




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
