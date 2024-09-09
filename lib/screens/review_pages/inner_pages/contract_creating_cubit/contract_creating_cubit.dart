

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/data/repository/contract_repository.dart';
import 'package:web_com/domain/address.dart';
import 'package:web_com/domain/company.dart';
import 'package:web_com/domain/contract.dart';
import 'package:web_com/domain/currency.dart';

import '../../../../config/app_endpoints.dart';
import '../../../../config/closing_form_enum.dart';
import '../../../../data/repository/client_repository.dart';
import '../../../../domain/client.dart';
import '../../../../utils/custom_exeption.dart';
import '../review_profile_cubit/review_profile_cubit.dart';

part 'contract_creating_state.dart';

class ContractCreatingCubit extends Cubit<ContractCreatingState> {
  ContractCreatingCubit() : super(ContractCreatingInitial());

  Future<Client?> getClientData(BuildContext context) async {
    try {
      String url = '${AppEndpoints.address}${AppEndpoints.clientMe}';
      Client? client = await ClientRepository.getClient(context, url);

      return client;
    } catch (e) {
      if (e is DioException) {
        CustomException exception = CustomException.fromDioException(e);
        print(exception);
      } else {
        rethrow;
      }

      return null;
    }
  }

  Future<void> contractCreate(BuildContext context) async {

      try{
        Client? client = await getClientData(context);

        Contract contract = Contract(null, null, client,null, null,null, null, null,null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

        String url = '${AppEndpoints.address}${AppEndpoints.createContract}';

        bool value = await ContractRepository.createContract(context, url, contract);

        if(value){
          emit(ContractCreatingSuccess());
        }

      }catch(e){
        if(e is DioException){
          CustomException exception = CustomException.fromDioException(e);

          emit(ContractCreatingError(errorMessage: exception.message, positive: false));
        }else{
          rethrow;
        }
      }
  }

}
