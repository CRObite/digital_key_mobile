

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/config/app_endpoints.dart';
import 'package:web_com/data/repository/client_repository.dart';
import 'package:web_com/domain/client.dart';
import 'package:web_com/utils/custom_exeption.dart';

part 'review_profile_state.dart';

class ReviewProfileCubit extends Cubit<ReviewProfileState> {
  ReviewProfileCubit() : super(ReviewProfileInitial());

  Future<void> getClientData() async {
    try{
      String url = '${AppEndpoints.address}${AppEndpoints.clientMe}';
      Client? client =  await ClientRepository.getClient(url);

      if(client!= null) {

        emit(ReviewProfileSuccess(client: client));
      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        emit(ReviewProfileError(errorText: exception.message));
      }else{
        rethrow;
      }
    }
  }
}
