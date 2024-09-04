
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/app_shadow.dart';
import 'package:web_com/data/local/file_picker_helper.dart';
import 'package:web_com/widgets/custom_drop_down.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/go_back_row.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../../config/app_box_decoration.dart';
import '../../../domain/contract_data_container.dart';
import '../../../widgets/check_box_row.dart';
import '../../../widgets/file_picker_container.dart';

class ContractCreatingPage extends StatefulWidget {
  const ContractCreatingPage({super.key});

  @override
  State<ContractCreatingPage> createState() => _ContractCreatingPageState();
}

class _ContractCreatingPageState extends State<ContractCreatingPage> {

  List<String> typeLabels = ['Юридическое лицо','Индивидуальный предприниматель','Физическое лицо', 'Партнер'];
  int selected = 0;

  @override
  void initState() {
    fillContainer();
    super.initState();
  }

  TextEditingController binController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController realAddressController = TextEditingController();

  TextEditingController contactPersonController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController emailForEDOController = TextEditingController();

  TextEditingController bikController = TextEditingController();
  TextEditingController iikController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController postController = TextEditingController();


  TextEditingController surnameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController iinController = TextEditingController();

  List<ContractDataContainer> allContainerData = [];

  bool selectedFirstCheckBox = false;
  bool selectedSecondCheckBox = false;

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
          ContainerComponent(ContainerType.checkBox, 'Совпадает с юридическим',),
        ]),
        ContractDataContainer('assets/icons/ic_contact_data.svg', 'Контактная информация', [
          ContainerComponent(ContainerType.textField, 'Контактное лицо', controller: contactPersonController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Должность', controller: positionController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Телефон', controller: phoneController,filedType: TextInputType.phone, important: true),
          ContainerComponent(ContainerType.textField, 'Email', controller: emailController,filedType: TextInputType.emailAddress, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_document_data.svg', 'Способ выставления документов', [
          ContainerComponent(ContainerType.dropDown, 'Способ получения', dropdownElements: [], important: true),
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
          ContainerComponent(ContainerType.dropDown, 'На основании', dropdownElements: [], important: true),
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
          ContainerComponent(ContainerType.dropDown, 'Способ получения', dropdownElements: [], important: true),
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
          ContainerComponent(ContainerType.dropDown, 'На основании', dropdownElements: [], important: true),
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
          ContainerComponent(ContainerType.textField, 'БИН', controller: binController,filedType: TextInputType.number, important: true),
          ContainerComponent(ContainerType.textField, 'Фамилия', controller: surnameController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Отчество', controller: middleNameController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'ИНН', controller: iinController,filedType: TextInputType.number, important: true),
        ]),
        ContractDataContainer('assets/icons/ic_address.svg', 'Адреса', [
          ContainerComponent(ContainerType.textField, 'Юридический адрес', controller: addressController,filedType: TextInputType.text, important: true),
        ]),
        ContractDataContainer('assets/icons/ic_contact_data.svg', 'Контактная информация', [
          ContainerComponent(ContainerType.textField, 'Телефон', controller: phoneController,filedType: TextInputType.phone, important: true),
          ContainerComponent(ContainerType.textField, 'Email', controller: emailController,filedType: TextInputType.emailAddress, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_document_data.svg', 'Способ выставления документов', [
          ContainerComponent(ContainerType.dropDown, 'Способ получения', dropdownElements: [], important: true),
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
          ContainerComponent(ContainerType.checkBox, 'Совпадает с юридическим',),
        ]),
        ContractDataContainer('assets/icons/ic_contact_data.svg', 'Контактная информация', [
          ContainerComponent(ContainerType.textField, 'Контактное лицо', controller: contactPersonController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Должность', controller: positionController,filedType: TextInputType.text, important: true),
          ContainerComponent(ContainerType.textField, 'Телефон', controller: phoneController,filedType: TextInputType.phone, important: true),
          ContainerComponent(ContainerType.textField, 'Email', controller: emailController,filedType: TextInputType.emailAddress, important: true),
        ]),

        ContractDataContainer('assets/icons/ic_document_data.svg', 'Способ выставления документов', [
          ContainerComponent(ContainerType.dropDown, 'Способ получения', dropdownElements: [], important: true),
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
          ContainerComponent(ContainerType.dropDown, 'На основании', dropdownElements: [], important: true),
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


    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GoBackRow(title: 'Новый договор'),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: typeLabels.length,
                      itemBuilder: (context, index){
                        return CheckBoxRow(
                          isCircle: true,
                          height: 30,
                            isChecked: index == selected,
                            onPressed: (value){
                              setState(() {
                                selected = index;
                              });
        
                              fillContainer();
                            },
                            child: Text(typeLabels[index])
                        );
                      }
                  ),
        
                  const SizedBox(height: 15,),
        
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.mainOrange.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(12))
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/ic_warning.svg'),
                        const SizedBox(width: 10,),
                        Flexible(
                          child: Text('Мы используем эту информацию при формировании и отправке закрывающих документов. Проверьте, что вы внесли верные данные',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: AppColors.secondaryGreyDarker,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
        
                  const SizedBox(height: 15,),
        
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allContainerData.length,
                    itemBuilder: (context,index){
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: AppBoxDecoration.boxWithShadow,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xffF3F4F6),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              child: Row(
                                children: [
                                  SvgPicture.asset(allContainerData[index].icon),
                                  const SizedBox(width: 12,),
                                  Text(allContainerData[index].name, style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold
                                  ),)
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListView.builder(
                                shrinkWrap: true,

                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: allContainerData[index].components.length,
                                itemBuilder: (context,componentIndex){
                                  if(allContainerData[index].components[componentIndex].type == ContainerType.textField){
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: TitledField(
                                        controller: allContainerData[index].components[componentIndex].controller!,
                                        title: allContainerData[index].components[componentIndex].name,
                                        type: allContainerData[index].components[componentIndex].filedType!,
                                        errorText: allContainerData[index].components[componentIndex].errorText,
                                        important: allContainerData[index].components[componentIndex].important,
                                      ),
                                    );
                                  }else if(allContainerData[index].components[componentIndex].type == ContainerType.dropDown){
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: CustomDropDown(
                                          title: allContainerData[index].components[componentIndex].name,
                                          important: allContainerData[index].components[componentIndex].important,
                                          dropDownList: allContainerData[index].components[componentIndex].dropdownElements ?? [],
                                          onSelected: (newValue){
                                            allContainerData[index].components[componentIndex].selectedValue = newValue;
                                          }
                                      ),
                                    );
                                  }else if(allContainerData[index].components[componentIndex].type == ContainerType.checkBox){
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: CheckBoxRow(
                                          isChecked: allContainerData[index].components[componentIndex].selectedValue ?? false,
                                          onPressed: (newValue){
                                             setState(() {
                                               allContainerData[index].components[componentIndex].selectedValue = newValue;
                                             });
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                              text: allContainerData[index].components[componentIndex].name,
                                              style: const TextStyle(fontSize: 12, color: Colors.black),
                                              children: allContainerData[index].components[componentIndex].important ? [
                                                const TextSpan(
                                                  text: ' *',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ] : [],
                                            ),
                                          )
                                      ),
                                    );
                                  }else if(allContainerData[index].components[componentIndex].type == ContainerType.filePicker){
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: FilePickerContainer(
                                        onPressed: () async {
                                          File? file = await FilePickerHelper.getFile();
                                          if(file != null){
                                            setState(() {
                                              allContainerData[index].components[componentIndex].selectedValue = file.path;
                                            });
                                          }
                                        },
                                        title: allContainerData[index].components[componentIndex].name,
                                        important: allContainerData[index].components[componentIndex].important,
                                        fileName: allContainerData[index].components[componentIndex].selectedValue,
                                        deletePressed: () {
                                          setState(() {
                                            allContainerData[index].components[componentIndex].selectedValue = null;
                                          });
                                        },
                                      ),
                                    );
                                  }else{
                                    return const SizedBox();
                                  }
                                }
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                  
                  selected != 2 ?  CheckBoxRow(isChecked: selectedFirstCheckBox, onPressed: (value){
                      setState(() {
                        selectedFirstCheckBox = !selectedFirstCheckBox;
                      });
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Соглашаюсь с ', // Regular text
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'условиями договора',
                            style: TextStyle(
                              color: AppColors.secondaryBlueDarker,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('условиями договора clicked');
                              },
                          ),
                          const TextSpan(
                            text: ' *', // Red * symbol
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    )
                  ): const SizedBox(),


                  CheckBoxRow(isChecked: selectedSecondCheckBox, onPressed: (value){
                    setState(() {
                      selectedSecondCheckBox = !selectedSecondCheckBox;
                    });
                  },
                      child: RichText(
                        text: TextSpan(
                          text: 'Разрешаю обработку персональных данных и соглашаюсь с', // Regular text
                          style: const TextStyle(fontSize: 12, color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'политикой конфиденциальности',
                              style: TextStyle(
                                color: AppColors.secondaryBlueDarker,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('условиями договора clicked');
                                },
                            ),
                            const TextSpan(
                              text: ' *', // Red * symbol
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  const SizedBox(height: 30,),
                  ExpandedButton(
                      onPressed: (){

                      },
                      child: const Text('Добавить договор', style: TextStyle(color: Colors.white),)
                  )
                  
                ],
              ),
            ),
            
            
          ],
        ),
      ),
    );
  }
}
