

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/config/client_type_enum.dart';
import 'package:web_com/data/repository/contract_repository.dart';
import 'package:web_com/domain/address.dart';
import 'package:web_com/domain/company.dart';
import 'package:web_com/domain/contract.dart';
import 'package:web_com/domain/currency.dart';

import '../../../../config/app_endpoints.dart';
import '../../../../config/closing_form_enum.dart';
import '../../../../config/format_enum.dart';
import '../../../../config/signer_type_enum.dart';
import '../../../../data/repository/client_repository.dart';
import '../../../../domain/client.dart';
import '../../../../domain/contract_data_container.dart';
import '../../../../utils/custom_exeption.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import '../review_profile_cubit/review_profile_cubit.dart';

part 'contract_creating_state.dart';

class ContractCreatingCubit extends Cubit<ContractCreatingState> {
  ContractCreatingCubit() : super(ContractCreatingInitial());

  List<String> typeLabels = ['Юридическое лицо','Индивидуальный предприниматель','Физическое лицо', 'Партнер'];
  int selected = 0;

  TextEditingController binController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController realAddressController = TextEditingController();
  bool sameAddress = false;

  TextEditingController contactPersonController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  ClosingForm? closingType;

  TextEditingController emailForEDOController = TextEditingController();

  TextEditingController bikController = TextEditingController();
  TextEditingController iikController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController postController = TextEditingController();


  TextEditingController nameController = TextEditingController();
  TextEditingController iinController = TextEditingController();

  List<ContractDataContainer> allContainerData = [];

  bool selectedFirstCheckBox = false;
  bool selectedSecondCheckBox = false;



  void typeSelected(Client client){
    if(client.type == ClientType.INDIVIDUAL){
      selected = 1;
    }else if(client.type == ClientType.BUSINESS){
      selected = 0;
    }

    fillContainer();
  }

  Future<void> setClientData(BuildContext context,NavigationPageCubit navigationPageCubit) async {

    emit(ContractCreatingDataLoading());

    try {

      Client? client = await getClientData(context);

      if(client != null){
        binController.text = client.binIin!;
        companyNameController.text = '${client.prefixShort ?? ''}''${client.name}';

        addressController.text = client.addresses!= null && client.addresses!.isNotEmpty ? client.addresses!.first.fullAddress ?? '' : '';
        realAddressController.text = client.addresses!= null ? client.addresses![1].fullAddress ?? '' : '';

        contactPersonController.text = client.contacts!= null ? client.contacts![0].fullName ?? '': '';
        positionController.text = client.owner!= null ? client.owner!.position!.name ?? '': '';
        phoneController.text = client.contacts!= null ? client.contacts![0].phone ?? '': '';
        emailController.text = client.contacts!= null ? client.contacts![0].email ?? '': '';

        closingType = client.closingForm;

        bikController.text = client.bankAccounts!= null && client.bankAccounts!.isNotEmpty ? client.bankAccounts!.first.iban ?? '': '';
        iikController.text = client.bankAccounts!= null && client.bankAccounts!.isNotEmpty ? client.bankAccounts!.first.iban ?? '': '';
        bankNameController.text = client.bankAccounts!= null && client.bankAccounts!.isNotEmpty ? client.bankAccounts!.first.name ?? '': '';

        iinController.text = client.binIin ?? '';
        nameController.text = client.name ?? '';

        typeSelected(client);
      }
    } catch (e) {
      if (e is DioException) {
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
      } else {
        rethrow;
      }

    }
  }

  Future<Client?> getClientData(BuildContext context) async {

    Client? client = await ClientRepository.getClient(context);

    return client;
  }

  Future<void> contractCreate(BuildContext context,NavigationPageCubit navigationPageCubit) async {

      try{
        Client? client = await getClientData(context);

        Contract contract = Contract(null, null, client, null, null, null, client!.id, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

        bool value = await ContractRepository.createContract(context,contract);

        if(value){
          emit(ContractCreatingSuccess());
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

  Future<void> contractDraftCreate(BuildContext context,NavigationPageCubit navigationPageCubit) async {

    try{
      Client? client = await getClientData(context);

      Contract contract = Contract(null, null, client, null, null, null, client!.id, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

      bool value = await ContractRepository.createDraftContract(context,contract);

      if(value){
        emit(ContractCreatingSuccess());
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


  void fillContainer() {
    allContainerData.clear();

    switch(selected){
      case 0: allContainerData.addAll([
        ContractDataContainer('assets/icons/ic_main_data.svg', 'Основные данные', [
          ContainerComponent(ContainerType.textField, 'БИН', controller: binController,filedType: TextInputType.number, important: true),
          ContainerComponent(ContainerType.textField, 'Юридическое название организации', controller: companyNameController,filedType: TextInputType.text, important: true)
        ]),
        ContractDataContainer('assets/icons/ic_address.svg', 'Адреса', [
          ContainerComponent(ContainerType.textField, 'Юридический адрес', controller: addressController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Фактический адрес ', controller: realAddressController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.checkBox, 'Совпадает с юридическим',selectedValue: addressController.text == realAddressController.text),
        ]),
        ContractDataContainer('assets/icons/ic_contact_data.svg', 'Контактная информация', [
          ContainerComponent(ContainerType.textField, 'Контактное лицо', controller: contactPersonController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Должность', controller: positionController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Телефон', controller: phoneController,filedType: TextInputType.phone, important: true),
          ContainerComponent(ContainerType.textField, 'Email', controller: emailController,filedType: TextInputType.emailAddress, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_document_data.svg', 'Способ выставления документов', [
          ContainerComponent(ContainerType.dropDown, 'Способ получения', dropdownElements: getClosingFormDescriptions(), important: true, selectedValue: closingType?.description ),
          ContainerComponent(ContainerType.textField, 'Email для выставления ЭДО', controller: emailForEDOController,filedType: TextInputType.emailAddress, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_bank.svg', 'Банк', [
          ContainerComponent(ContainerType.textField, 'БИК', controller: bikController,filedType: TextInputType.number, important: true),
          ContainerComponent(ContainerType.textField, 'ИИК', controller: iikController,filedType: TextInputType.number, important: true),
          ContainerComponent(ContainerType.textField, 'Наименование банка', controller: bankNameController,filedType: TextInputType.text, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_contract_person.svg', 'Подписант', [
          ContainerComponent(ContainerType.textField, 'Имя и Фамилия', controller: fullNameController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Должность', controller: postController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.dropDown, 'На основании', dropdownElements: getSignerTypeDescriptions(), important: true),
          ContainerComponent(ContainerType.filePicker, 'Файл-основание', important: true),
        ]),

        ContractDataContainer('assets/icons/ic_accept_documents.svg', 'Разрешительные документы', [
          ContainerComponent(ContainerType.filePicker, 'Справка о государственной регистрации', important: true),
          ContainerComponent(ContainerType.filePicker, 'Реквизиты', important: true),
          ContainerComponent(ContainerType.filePicker, 'Приказ', important: true),
          ContainerComponent(ContainerType.filePicker, 'Свидетельство о НДС', important: true),
          ContainerComponent(ContainerType.filePicker, 'Дополнительные документы', important: true),
        ]),

      ]);
      break;
      case 1: allContainerData.addAll([
        ContractDataContainer('assets/icons/ic_main_data.svg', 'Основные данные', [
          ContainerComponent(ContainerType.textField, 'БИН', controller: binController,filedType: TextInputType.number, important: true),
          ContainerComponent(ContainerType.textField, 'Юридическое название организации', controller: companyNameController,filedType: TextInputType.text, important: true)
        ]),
        ContractDataContainer('assets/icons/ic_address.svg', 'Адреса', [
          ContainerComponent(ContainerType.textField, 'Юридический адрес', controller: addressController,filedType: TextInputType.text, important: true),
        ]),
        ContractDataContainer('assets/icons/ic_contact_data.svg', 'Контактная информация', [
          ContainerComponent(ContainerType.textField, 'Контактное лицо', controller: contactPersonController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Должность', controller: positionController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Телефон', controller: phoneController,filedType: TextInputType.phone, important: true),
          ContainerComponent(ContainerType.textField, 'Email', controller: emailController,filedType: TextInputType.emailAddress, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_document_data.svg', 'Способ выставления документов', [
          ContainerComponent(ContainerType.dropDown, 'Способ получения', dropdownElements: getClosingFormDescriptions(), important: true, selectedValue: closingType?.description),
          ContainerComponent(ContainerType.textField, 'Email для выставления ЭДО', controller: emailForEDOController,filedType: TextInputType.emailAddress, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_bank.svg', 'Банк', [
          ContainerComponent(ContainerType.textField, 'БИК', controller: bikController,filedType: TextInputType.number, important: true),
          ContainerComponent(ContainerType.textField, 'ИИК', controller: iikController,filedType: TextInputType.number, important: true),
          ContainerComponent(ContainerType.textField, 'Наименование банка', controller: bankNameController,filedType: TextInputType.text, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_contract_person.svg', 'Подписант', [
          ContainerComponent(ContainerType.textField, 'Имя и Фамилия', controller: fullNameController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Должность', controller: postController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.dropDown, 'На основании', dropdownElements: getSignerTypeDescriptions(), important: true),
          ContainerComponent(ContainerType.filePicker, 'Файл-основание', important: true),
        ]),

        ContractDataContainer('assets/icons/ic_accept_documents.svg', 'Разрешительные документы', [
          ContainerComponent(ContainerType.filePicker, 'Справка о государственной регистрации', important: true),
          ContainerComponent(ContainerType.filePicker, 'Реквизиты', important: true),
        ]),

      ]);
      break;
      case 2: allContainerData.addAll([
        ContractDataContainer('assets/icons/ic_main_data.svg', 'Основные данные', [
          ContainerComponent(ContainerType.textField, 'ИНН_БИН', controller: iinController,filedType: TextInputType.number, important: true),
          ContainerComponent(ContainerType.textField, 'ФИО', controller: nameController,filedType: TextInputType.text, important: true),
        ]),
        ContractDataContainer('assets/icons/ic_address.svg', 'Адреса', [
          ContainerComponent(ContainerType.textField, 'Юридический адрес', controller: addressController,filedType: TextInputType.text, important: true),
        ]),
        ContractDataContainer('assets/icons/ic_contact_data.svg', 'Контактная информация', [
          ContainerComponent(ContainerType.textField, 'Телефон', controller: phoneController,filedType: TextInputType.phone, important: true),
          ContainerComponent(ContainerType.textField, 'Email', controller: emailController,filedType: TextInputType.emailAddress, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_document_data.svg', 'Способ выставления документов', [
          ContainerComponent(ContainerType.dropDown, 'Способ получения', dropdownElements: getClosingFormDescriptions(), important: true, selectedValue: closingType?.description),
          ContainerComponent(ContainerType.textField, 'Email для выставления ЭДО', controller: emailForEDOController,filedType: TextInputType.emailAddress, important: true),
        ]),

      ]);
      break;
      case 3: allContainerData.addAll([
        ContractDataContainer('assets/icons/ic_main_data.svg', 'Основные данные', [
          ContainerComponent(ContainerType.textField, 'БИН', controller: binController,filedType: TextInputType.number, important: true),
          ContainerComponent(ContainerType.textField, 'Юридическое название организации', controller: companyNameController,filedType: TextInputType.text, important: true)
        ]),
        ContractDataContainer('assets/icons/ic_address.svg', 'Адреса', [
          ContainerComponent(ContainerType.textField, 'Юридический адрес', controller: addressController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Фактический адрес ', controller: realAddressController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.checkBox, 'Совпадает с юридическим',selectedValue: addressController.text == realAddressController.text),
        ]),
        ContractDataContainer('assets/icons/ic_contact_data.svg', 'Контактная информация', [
          ContainerComponent(ContainerType.textField, 'Контактное лицо', controller: contactPersonController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Должность', controller: positionController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Телефон', controller: phoneController,filedType: TextInputType.phone, important: true),
          ContainerComponent(ContainerType.textField, 'Email', controller: emailController,filedType: TextInputType.emailAddress, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_document_data.svg', 'Способ выставления документов', [
          ContainerComponent(ContainerType.dropDown, 'Способ получения', dropdownElements: getClosingFormDescriptions(), important: true, selectedValue: closingType?.description),
          ContainerComponent(ContainerType.textField, 'Email для выставления ЭДО', controller: emailForEDOController,filedType: TextInputType.emailAddress, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_bank.svg', 'Банк', [
          ContainerComponent(ContainerType.textField, 'БИК', controller: bikController,filedType: TextInputType.number, important: true),
          ContainerComponent(ContainerType.textField, 'ИИК', controller: iikController,filedType: TextInputType.number, important: true),
          ContainerComponent(ContainerType.textField, 'Наименование банка', controller: bankNameController,filedType: TextInputType.text, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_contract_person.svg', 'Подписант', [
          ContainerComponent(ContainerType.textField, 'Имя и Фамилия', controller: fullNameController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Должность', controller: postController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.dropDown, 'На основании', dropdownElements: getSignerTypeDescriptions(), important: true),
          ContainerComponent(ContainerType.filePicker, 'Файл-основание', important: true),
        ]),

        ContractDataContainer('assets/icons/ic_accept_documents.svg', 'Разрешительные документы', [
          ContainerComponent(ContainerType.filePicker, 'Справка о государственной регистрации', important: true),
          ContainerComponent(ContainerType.filePicker, 'Реквизиты', important: true),
          ContainerComponent(ContainerType.filePicker, 'Приказ', important: true),
          ContainerComponent(ContainerType.filePicker, 'Свидетельство о НДС', important: true),
          ContainerComponent(ContainerType.filePicker, 'Дополнительные документы', important: true),
        ]),

      ]);
      break;
    }

    emit(ContractCreatingFetchingSuccess(contractDataContainer: allContainerData));
  }
}
