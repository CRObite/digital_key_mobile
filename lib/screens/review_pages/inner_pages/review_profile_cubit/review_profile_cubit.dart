

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/config/app_endpoints.dart';
import 'package:web_com/data/repository/client_repository.dart';
import 'package:web_com/domain/client.dart';
import 'package:web_com/domain/contacts_card_info.dart';
import 'package:web_com/utils/custom_exeption.dart';

import '../../../../config/app_texts.dart';
import '../../../../domain/contact.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

part 'review_profile_state.dart';

class ReviewProfileCubit extends Cubit<ReviewProfileState> {
  ReviewProfileCubit() : super(ReviewProfileInitial());

  Client? client;
  List<ContactsCardInfo> contactsCardList = [];

  int currentPosition = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController iinController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController realAddressController = TextEditingController();


  Future<void> getClientData(BuildContext context) async {

    emit(ReviewProfileLoading());

    try{
      Client? data =  await ClientRepository.getClient(context);

      if(data!= null) {
        client = data;
        nameController.text = data.name ?? '';
        iinController.text = data.binIin ?? '';
        addressController.text = data.addresses?[0].fullAddress ?? '';
        realAddressController.text = data.addresses?[1].fullAddress ?? '';
        createContactsCardList(data);
        emit(ReviewProfileSuccess(client: data));
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

  void createContactsCardList(Client client) async {

    if(client.contacts!= null){

      TextEditingController nameController = TextEditingController();
      TextEditingController phoneController = TextEditingController();
      TextEditingController emailController = TextEditingController();

      for(var item in client.contacts!){
        nameController.text = item.fullName ?? '';
        phoneController.text = item.phone ?? '';
        emailController.text = item.email ?? '';

        contactsCardList.add(ContactsCardInfo(id:item.id,nameController, phoneController, emailController, item.contactPerson ?? false));
      }
    }
  }


  List<Contact> getContactList() {

    List<Contact> listOfContact = [];

    for(var item in contactsCardList){
      listOfContact.add(Contact(item.id, item.nameController.text,item.phoneController.text , item.emailController.text, item.contactPerson));
    }

    return listOfContact;
  }

  void contactPersonChange(int index, bool value) async {

    if(!value){
      contactsCardList[index].contactPerson = value;
    }else{
      contactsCardList[index].contactPerson = value;
      contactsCardList.forEach((item) => item.contactPerson = false);
    }
    emit(ReviewProfileSuccess(client: client!));
  }

  void deleteContact(int index) async {
    contactsCardList.removeAt(index);
    emit(ReviewProfileSuccess(client: client!));
  }

  void addContact() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    contactsCardList.add(ContactsCardInfo(nameController, phoneController, emailController, false));
    emit(ReviewProfileSuccess(client: client!));
  }

  Future<void> saveDraftData(BuildContext context, Client client,NavigationPageCubit navigationPageCubit) async {
    try{

      client.name = nameController.text;
      client.binIin = iinController.text;
      client.contacts = getContactList();

      bool value =  await ClientRepository.setDraft(context, client);

      if(value) {
        navigationPageCubit.showMessage(AppTexts.changesWasSaved, true);
      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        navigationPageCubit.showMessage(exception.message, true);
        getClientData(context);
      }else{
        rethrow;
      }
    }
  }

  Future<void> saveClientChangesData(BuildContext context,Client client, NavigationPageCubit navigationPageCubit) async {
    try{

      client.name = nameController.text;
      client.binIin = iinController.text;
      client.contacts = getContactList();

      bool value =  await ClientRepository.setClientChanges(context, client);

      if(value) {
        navigationPageCubit.showMessage('Изменения сохранены', true);
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
