

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/config/service_operation_type_enum.dart';
import 'package:web_com/data/repository/contract_repository.dart';
import 'package:web_com/data/repository/service_repository.dart';
import 'package:web_com/domain/client_contract_service.dart';
import 'package:web_com/domain/contract.dart';
import 'package:web_com/domain/service_operation.dart';

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
        emit(NewOperationFirstStep(client: data));
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

  Future<void> passFirstStage(BuildContext context, NavigationPageCubit navigationPageCubit,ServiceOperationType type, Contract contract,Client client ) async {

    try{
      ServiceOperation serviceOperation = ServiceOperation(null, null, null, null, null, null, null, type, null, null, contract, contract.id, null, null, null, null, null, null, null, null, null, null, null, null);

      ServiceOperation? operation = await ServiceRepository().createOperations(context, serviceOperation);

      if(operation!= null){
        emit(NewOperationSecondStep(operation: operation, client: client,));
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


  Future<void> passSecondStage(BuildContext context, NavigationPageCubit navigationPageCubit,ServiceOperation operation, double amount, ClientContractService? toService,ClientContractService? fromService,Client client ) async {

    try{
      operation.amount = amount;
      operation.toService = toService;
      operation.fromService = fromService;
      operation.toServiceId = toService?.id;
      operation.fromServiceId = fromService?.id;

      ServiceOperation? newOperation = await ServiceRepository().updateOperations(context, operation);

      if(newOperation!= null){
        navigationPageCubit.showMessage('Операция успешна', true);
        emit(NewOperationSecondStep(operation: operation, client: client,));
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


  Future<void> alreadyHasOperation(BuildContext context, NavigationPageCubit navigationPageCubit,ServiceOperation operation) async {

    try{
      Client? data = await ClientRepository.getClient(context);

      if(data!= null){
        emit(NewOperationSecondStep(operation: operation, client: data));
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

