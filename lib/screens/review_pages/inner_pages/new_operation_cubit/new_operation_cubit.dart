

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/client_repository.dart';
import '../../../../domain/client.dart';
import '../../../../utils/custom_exeption.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

part 'new_operation_state.dart';

class NewOperationCubit extends Cubit<NewOperationState> {
  NewOperationCubit() : super(NewOperationInitial());

  Future<void> getInitData(BuildContext context, NavigationPageCubit navigationPageCubit,) async {
    emit(NewOperationLoading());

    try{
      Client? data = await ClientRepository.getClient(context);

      if(data!= null){
        emit(NewOperationFetched(client: data));
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
}

