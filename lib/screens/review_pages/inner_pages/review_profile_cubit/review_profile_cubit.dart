

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/config/app_endpoints.dart';
import 'package:web_com/data/repository/client_repository.dart';
import 'package:web_com/domain/client.dart';
import 'package:web_com/domain/contacts_card_info.dart';
import 'package:web_com/utils/custom_exeption.dart';

import '../../../../domain/contact.dart';

part 'review_profile_state.dart';

class ReviewProfileCubit extends Cubit<ReviewProfileState> {
  ReviewProfileCubit() : super(ReviewProfileInitial());

  Future<void> getClientData(BuildContext context) async {

    emit(ReviewProfileLoading());

    try{
      Client? client =  await ClientRepository.getClient(context);

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


  Future<void> saveDraftData(BuildContext context,Client client, String name, String iin, List<Contact> contacts) async {
    try{


      client.name = name;
      client.binIin = iin;
      client.contacts = contacts;

      bool value =  await ClientRepository.setDraft(context, client);

      if(value) {
        emit(ReviewProfileDraftSet());
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

  Future<void> saveClientChangesData(BuildContext context,Client client, String name, String iin, List<Contact> contacts) async {
    try{


      client.name = name;
      client.binIin = iin;
      client.contacts = contacts;

      bool value =  await ClientRepository.setClientChanges(context, client);

      if(value) {
        emit(ReviewProfileDraftSet());
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

  List<ContactsCardInfo> setContactInfo(Client? client) {

    List<ContactsCardInfo> contactInfo = [];
    
    if(client!= null){
      if(client.contacts!= null){
        for(var item in client.contacts!){
          TextEditingController nameController = TextEditingController();
          TextEditingController phoneController = TextEditingController();
          TextEditingController emailController = TextEditingController();

          nameController.text = item.fullName ?? '';
          phoneController.text = item.phone ?? '';
          emailController.text = item.email ?? '';

          contactInfo.add(
              ContactsCardInfo(item.id,nameController, phoneController, emailController, item.contactPerson ?? false)
          );
        }
      }
    }else{
      TextEditingController nameController = TextEditingController();
      TextEditingController phoneController = TextEditingController();
      TextEditingController emailController = TextEditingController();


      contactInfo.add(
          ContactsCardInfo(null, nameController, phoneController, emailController, false)
      );
    }
    
    return contactInfo;
  }

  List<Contact> getContactFromCard(List<ContactsCardInfo> info) {

    List<Contact> contactInfo = [];

    for(var data in info){
      contactInfo.add(Contact(
          data.id,
          data.nameController.text,
          data.phoneController.text,
          data.emailController.text, data.contactPerson)
      );
    }

    return contactInfo;
  }




}
