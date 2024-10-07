

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

  Client? client;
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

    try{
      Client? data =  await ClientRepository.getClient(context);
      listOfCurrency =  await CurrencyRepository.getAllCurrencies(context);
      listOfPosition =  await PositionRepository().getPositions(context);

      if(data!= null) {
        client = data;
        signer = data.signer ?? Signer(null, null, null, null, null, null, null, null, null, null);
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
      contactsCardList.forEach((item) => item.contactPerson = false);
      contactsCardList[index].contactPerson = value;
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
      client.addresses = [
        Address(addressController.text, AddressType.LEGAL),
        Address(realAddressController.text, AddressType.PHYSICAL),
      ];
      client.bankAccounts = getBankList();
      signer?.name = signerNameController.text;
      client.signer = signer;

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
      client.addresses = [
        Address(addressController.text, AddressType.LEGAL),
        Address(realAddressController.text, AddressType.PHYSICAL),
      ];
      client.bankAccounts = getBankList();
      signer?.name = signerNameController.text;
      client.signer = signer;

      bool value =  await ClientRepository.setClientChanges(context, client);

      if(value) {
        navigationPageCubit.showMessage('Изменения сохранены', true);
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




  void createBankCardList(Client client) async {

    if(client.bankAccounts!= null){

      TextEditingController bankAccountController = TextEditingController();

      for(var item in client.bankAccounts!){
        bankAccountController.text = item.iban ?? '';

        bankCardList.add(BankCardInfo(item.id ,item.bank!, bankAccountController, item.mainAccount ?? false, listOfCurrency, item.currency! ));
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
    emit(ReviewProfileSuccess(client: client!));
  }

  void deleteBankAccount(int index) async {
    bankCardList.removeAt(index);
    emit(ReviewProfileSuccess(client: client!));
  }

  void addBankAccount() async {
    TextEditingController bankAccountController = TextEditingController();
    bankCardList.add(BankCardInfo(null, null, bankAccountController, false, listOfCurrency, null));
    emit(ReviewProfileSuccess(client: client!));
  }

  void selectBankCurrency(int index ,Currency value) async {

    bankCardList[index].currencySelected = value;

    emit(ReviewProfileSuccess(client: client!));
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
    signer?.stampFile = null;
    signer?.stampFileId = null;
  }


}
