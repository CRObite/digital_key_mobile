

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/data/repository/file_repository.dart';
import 'package:web_com/domain/attachment.dart';

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

    emit(ProfileScreenLoading());


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


  Future<void> setNewAvatar(BuildContext context,User user,String filePath) async {

    try{

      if(user.avatar!= null){

        String url = '${AppEndpoints.address}${AppEndpoints.updateFiles}${user.avatar?.id}';

        bool value = await FileRepository.updateFile(context, url, filePath,);

        if(value) {
          getUserData(context);
        }

      }else{
        String url = '${AppEndpoints.address}${AppEndpoints.createFiles}';

        Attachment? value = await FileRepository.uploadFile(context, url, filePath);

        if(value!= null){
          updateUserAvatar(context, user, value.id);
        }
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


  Future<void> updateUserAvatar(BuildContext context,User user,int avatarId) async {

    try{
      String url = '${AppEndpoints.address}${AppEndpoints.updateUser}';

      user.avatar!.id = avatarId;

      bool value = await AuthRepository.updateUser(context, url, user);

      if(value){
        getUserData(context);
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
