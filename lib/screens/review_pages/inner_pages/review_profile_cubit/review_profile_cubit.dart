

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/config/address_type_enum.dart';
import 'package:web_com/config/app_endpoints.dart';
import 'package:web_com/data/repository/client_repository.dart';
import 'package:web_com/data/repository/currency_repository.dart';
import 'package:web_com/data/repository/file_repository.dart';
import 'package:web_com/data/repository/position_repository.dart';
import 'package:web_com/domain/address.dart';
import 'package:web_com/domain/attachment.dart';
import 'package:web_com/domain/bank_account.dart';
import 'package:web_com/domain/client.dart';
import 'package:web_com/domain/contacts_card_info.dart';
import 'package:web_com/domain/currency.dart';
import 'package:web_com/utils/custom_exeption.dart';

import '../../../../config/app_texts.dart';
import '../../../../config/signer_type_enum.dart';
import '../../../../domain/bank.dart';
import '../../../../domain/contact.dart';
import '../../../../domain/position.dart';
import '../../../../domain/signer.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

part 'review_profile_state.dart';

class ReviewProfileCubit extends Cubit<ReviewProfileState> {
  ReviewProfileCubit() : super(ReviewProfileInitial());

  List<ContactsCardInfo> contactsCardList = [];
  List<BankCardInfo> bankCardList = [];
  List<Currency> listOfCurrency = [];
  List<Position> listOfPosition = [];

  int currentPosition = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController iinController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController realAddressController = TextEditingController();
  TextEditingController signerNameController = TextEditingController();

  Signer? signer;

  Future<void> getClientData(BuildContext context) async {

    emit(ReviewProfileLoading());
    contactsCardList.clear();
    bankCardList.clear();


    try{
      Client? data =  await ClientRepository.getClient(context);
      listOfCurrency =  await CurrencyRepository.getAllCurrencies(context);
      listOfPosition =  await PositionRepository().getPositions(context);

      if(data!= null) {
        signer = data.signer ?? Signer(null, null, null, null, null, null, null, null, null, null);
        signerNameController.text = signer?.name ?? '';
        nameController.text = data.name ?? '';
        iinController.text = data.binIin ?? '';
        addressController.text = data.addresses?[0].fullAddress ?? '';
        realAddressController.text = data.addresses?[1].fullAddress ?? '';
        createContactsCardList(data);
        createBankCardList(data);
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



      for(var item in client.contacts!){

        TextEditingController nameController = TextEditingController();
        TextEditingController phoneController = TextEditingController();
        TextEditingController emailController = TextEditingController();

        nameController.text = item.fullName ?? '';
        phoneController.text = item.phone ?? '';
        emailController.text = item.email ?? '';

        contactsCardList.add(ContactsCardInfo(id:item.id,nameController, phoneController, emailController, item.contactPerson ?? false));
      }

      if(contactsCardList.isEmpty){
        contactsCardList.add(ContactsCardInfo(TextEditingController(), TextEditingController(), TextEditingController(), false));
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
      contactsCardList.forEach((item) => item.contactPerson = false);
      contactsCardList[index].contactPerson = value;
    }

  }

  void deleteContact(int index, Client client) async {
    contactsCardList.removeAt(index);
    emit(ReviewProfileSuccess(client: client));
  }

  void addContact(Client client) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    contactsCardList.add(ContactsCardInfo(nameController, phoneController, emailController, false));
    emit(ReviewProfileSuccess(client: client));
  }

  Future<void> saveDraftData(BuildContext context, Client client,NavigationPageCubit navigationPageCubit) async {
    try{

      bool value =  await ClientRepository.setDraft(context, await setNewClientData(context, client,navigationPageCubit));

      if(value) {
        getClientData(context);
        navigationPageCubit.showMessage(AppTexts.changesWasSaved, true);
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

  Future<Client> setNewClientData(BuildContext context, Client client,NavigationPageCubit navigationPageCubit) async {
    Client newClient  = client;
    newClient.name = nameController.text;
    newClient.binIin = iinController.text;
    newClient.contacts = getContactList();


    if(newClient.addresses != null && newClient.addresses!.isNotEmpty){
      newClient.addresses?[0].fullAddress = addressController.text;
      if(newClient.addresses!.length > 1){
        newClient.addresses?[1].fullAddress = realAddressController.text;
      }else{
        newClient.addresses?.add(Address(null,realAddressController.text, AddressType.PHYSICAL));
      }
    }else{
      newClient.addresses = [
        Address(null,addressController.text, AddressType.LEGAL),
        Address(null,realAddressController.text, AddressType.PHYSICAL),
      ];
    }

    newClient.bankAccounts = getBankList();

    if(stampFilePath!= null && stampFilePath!.isNotEmpty){
      signerSetStampFile(context, stampFilePath!, navigationPageCubit);
    }
    signer?.name = signerNameController.text;
    newClient.signer = signer;


    if(permits[0]!= null){
      client = await setStateRegistrationCertificate(context, client, permits[0]!, navigationPageCubit);
    }
    if(permits[1]!= null){
      client = await setRequisites(context, client, permits[1]!, navigationPageCubit);
    }
    if(permits[2]!= null){
      client = await setOrder(context, client, permits[2]!, navigationPageCubit);
    }

    if(permits[3]!= null){
      client = await setVatCertificate(context, client, permits[3]!, navigationPageCubit);
    }


    return newClient;
  }

  Future<void> saveClientChangesData(BuildContext context,Client client, NavigationPageCubit navigationPageCubit) async {
    try{
      bool value =  await ClientRepository.setClientChanges(context, await setNewClientData(context, client,navigationPageCubit));

      if(value) {
        getClientData(context);
        navigationPageCubit.showMessage('Изменения сохранены', true);
      }

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        navigationPageCubit.showMessage(exception.message, false);

        emit(ReviewProfileSuccess(client: client,fieldErrors: e.response?.data['field_errors']['client']));
      }else{
        rethrow;
      }
    }
  }




  void createBankCardList(Client client) async {

    if(client.bankAccounts!= null){

      for(var item in client.bankAccounts!){
        TextEditingController bankAccountController = TextEditingController();

        bankAccountController.text = item.iban ?? '';

        bankCardList.add(BankCardInfo(item.id ,item.bank!, bankAccountController, item.mainAccount ?? false, listOfCurrency, item.currency! ));
      }


      if(bankCardList.isEmpty){
        bankCardList.add(BankCardInfo(null, null, TextEditingController(), true, listOfCurrency, null));
      }
    }
  }


  List<BankAccount> getBankList() {

    List<BankAccount> listOfBankAccount = [];

    for(var item in bankCardList){
      listOfBankAccount.add(BankAccount(item.id, null, item.bankAccount.text, null, item.currencySelected, item.currencySelected?.id, item.selected, item.selected?.id, null, null, item.mainAccount));
    }

    return listOfBankAccount;
  }

  void mainBankAccountChange(int index, bool value) async {

    if(!value){
      bankCardList[index].mainAccount = value;
    }else{
      bankCardList.forEach((item) => item.mainAccount = false);
      bankCardList[index].mainAccount = value;
    }
  }

  void deleteBankAccount(int index,Client client) async {
    bankCardList.removeAt(index);
    emit(ReviewProfileSuccess(client: client));
  }

  void addBankAccount(Client client) async {
    TextEditingController bankAccountController = TextEditingController();
    bankCardList.add(BankCardInfo(null, null, bankAccountController, false, listOfCurrency, null));
    emit(ReviewProfileSuccess(client: client));
  }

  void selectBankCurrency(int index ,Currency value, Client client) async {

    bankCardList[index].currencySelected = value;

    emit(ReviewProfileSuccess(client: client));
  }

  void selectBank(int index ,Bank value) async {
    bankCardList[index].selected = value;
  }

  void signerPositionSelected(Position value) async {
    signer!.position = value;
    signer!.positionId = value.id;
  }

  void signerTypeSelected(SignerType value) async {
    signer!.type = value;
  }

  String? stampFilePath;

  void signerSetStampFile(BuildContext context, String file, NavigationPageCubit navigationPageCubit) async {
    try{

      if(signer?.stampFileId != null){
        FileRepository.updateFile(context, signer!.stampFileId!, file);
      }else{
        Attachment? attachment = await FileRepository.uploadFile(context, file);

        if(attachment!= null){
          signer?.stampFile = attachment;
          signer?.stampFileId = attachment.id;
        }
      }
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        navigationPageCubit.showMessage(exception.message, true);
      }else{
        rethrow;
      }
    }
  }


  void signerDeleteStampFile() async {
    print("deleted");
    stampFilePath = null;
  }


  List<String?> permits = [null,null,null,null];

  Future<Client> setStateRegistrationCertificate(BuildContext context,Client client, String file, NavigationPageCubit navigationPageCubit) async {
    try{

      if(client.stateRegistrationCertificate != null){
        FileRepository.updateFile(context, client.stateRegistrationCertificate!.id, file);
      }else{
        Attachment? attachment = await FileRepository.uploadFile(context, file);

        if(attachment!= null){
          client.stateRegistrationCertificate = attachment;
        }
      }

      return client;
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        navigationPageCubit.showMessage(exception.message, true);
      }else{
        rethrow;
      }
      return client;
    }
  }

  Future<Client> setVatCertificate(BuildContext context,Client client, String file, NavigationPageCubit navigationPageCubit) async {
    try{

      if(client.vatCertificate != null){
        FileRepository.updateFile(context, client.vatCertificate!.id, file);
      }else{
        Attachment? attachment = await FileRepository.uploadFile(context, file);

        if(attachment!= null){
          client.vatCertificate = attachment;
        }
      }

      return client;
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        navigationPageCubit.showMessage(exception.message, true);
      }else{
        rethrow;
      }
      return client;
    }
  }


  Future<Client> setOrder(BuildContext context,Client client, String file, NavigationPageCubit navigationPageCubit) async {
    try{

      if(client.order != null){
        FileRepository.updateFile(context, client.order!.id, file);
      }else{
        Attachment? attachment = await FileRepository.uploadFile(context, file);

        if(attachment!= null){
          client.order = attachment;
        }
      }

      return client;
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        navigationPageCubit.showMessage(exception.message, true);
      }else{
        rethrow;
      }
      return client;
    }
  }

  Future<Client> setRequisites(BuildContext context,Client client, String file, NavigationPageCubit navigationPageCubit) async {
    try{

      if(client.order != null){
        FileRepository.updateFile(context, client.requisites!.id, file);
      }else{
        Attachment? attachment = await FileRepository.uploadFile(context, file);

        if(attachment!= null){
          client.requisites = attachment;
        }
      }

      return client;
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);

        navigationPageCubit.showMessage(exception.message, true);
      }else{
        rethrow;
      }
      return client;
    }
  }

}
