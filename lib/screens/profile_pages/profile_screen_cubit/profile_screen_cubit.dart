

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
      User? user =  await AuthRepository.getMe(context);

      Client? client =  await ClientRepository.getClient(context);

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

        bool value = await FileRepository.updateFile(context, user.avatar!.id, filePath,);

        if(value) {
          getUserData(context);
        }

      }else{
        Attachment? value = await FileRepository.uploadFile(context,filePath);

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


      user.avatar!.id = avatarId;

      bool value = await AuthRepository.updateUser(context,user);

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

  Future<void> updateUser(BuildContext context,User user, String name, String email,String phone,String date,) async {

    try{

      user.name = name;
      user.email = email;
      user.mobile = phone;
      user.birthDay = date;

      bool value = await AuthRepository.updateUser(context,user);

      if(value){

        emit(ProfileScreenEditSuccess());

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
