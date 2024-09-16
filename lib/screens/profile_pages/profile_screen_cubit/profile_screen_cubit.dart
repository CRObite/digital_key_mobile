

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_endpoints.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/client_repository.dart';
import '../../../domain/client.dart';
import '../../../domain/user.dart';
import '../../../utils/custom_exeption.dart';

part 'profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  ProfileScreenCubit() : super(ProfileScreenInitial());

  Future<void> getUserData(BuildContext context) async {
    try{
      String url = '${AppEndpoints.address}${AppEndpoints.getMe}';

      User? user =  await AuthRepository.getMe(context,url);

      url = '${AppEndpoints.address}${AppEndpoints.clientMe}';

      Client? client =  await ClientRepository.getClient(context,url);


      if(user!= null && client!= null){
        emit(ProfileScreenSuccess(user: user, client: client));
      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        emit(ProfileScreenError(errorText: exception.message));
      }else{
        rethrow;
      }
    }
  }
}
