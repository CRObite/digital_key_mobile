import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_toast.dart';
import 'package:web_com/data/repository/auth_repository.dart';
import 'package:web_com/screens/authorization_pages/registration_page_cubit/registration_page_cubit.dart';

import '../../config/app_colors.dart';
import '../../config/app_texts.dart';
import '../../widgets/check_box_row.dart';
import '../../widgets/expanded_button.dart';
import '../../widgets/titled_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController iinController = TextEditingController();

  bool firstSelected = false;
  bool secondSelected = false;
  bool thirdSelected = false;
  bool fourthSelected = false;

  String errorText = '';
  Map<String,dynamic> errorField = {};

  RegistrationPageCubit registrationPageCubit = RegistrationPageCubit();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context)=> registrationPageCubit,
        child: BlocListener<RegistrationPageCubit,RegistrationPageState>(
          listener: (context, state){
            if(state is RegistrationPageError){
              setState(() {
                errorText = state.errorText;
                errorField = state.filedErrors;
              });
            }else if(state is RegistrationPageSuccess){
              context.goNamed(
                  'registrationSecondPage',
                  extra: {
                  'name': '${nameController.text} ${surnameController.text}',
                  'phone': phoneController.text,
                  'iin': iinController.text,
                  'partner': thirdSelected,
                  'type': firstSelected ?
                    ClientType.BUSINESS.toString().split('.').last :
                    ClientType.INDIVIDUAL.toString().split('.').last
                }
              );
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(AppTexts.registrationSmall,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          TitledField(
                            controller: nameController,
                            title: AppTexts.name,
                            type: TextInputType.text,
                            errorText: errorField.containsKey('name') ?
                              errorField['name']: null,
                            important: true,
                          ),
                          const SizedBox(height: 10,),
                          TitledField(
                              controller: surnameController,
                              title: AppTexts.surname,
                              type: TextInputType.text,
                          ),
                          const SizedBox(height: 10,),
                          TitledField(
                              controller: phoneController,
                              title: AppTexts.phone,
                              type: TextInputType.phone,
                            errorText: errorField.containsKey('mobile') ?
                            errorField['mobile']: null,
                          ),
                          const SizedBox(height: 10,),
                          TitledField(
                              controller: iinController,
                              title: AppTexts.iin,
                              type: TextInputType.number,
                            errorText: errorField.containsKey('bin_iin') ?
                            errorField['bin_iin']: null,
                            important: true,
                          ),
                          SizedBox(height: errorText.isNotEmpty ? 10: 0,),
                          errorText.isNotEmpty ? Text(
                            errorText,
                            style: const TextStyle(fontSize: 12,color: Colors.red),
                          ): const SizedBox(),
                        ],
                      ),
                    ),
                
                    CheckBoxRow(
                      height: 40,
                      isChecked: firstSelected,
                      onPressed: (value) {
                        if(secondSelected){
                          secondSelected = false;
                        }
                        setState(() {
                          firstSelected = value;
                        });
                      },
                      child: Text(AppTexts.proprietorPerson),
                    ),
                    CheckBoxRow(
                      height: 40,
                      isChecked: secondSelected,
                      onPressed: (value) {
                        if(firstSelected){
                          firstSelected = false;
                        }
                        if(thirdSelected){
                          thirdSelected = false;
                        }
                        setState(() {
                          secondSelected = value;
                        });
                      },
                      child: Text(AppTexts.individualPerson),
                    ),
                    CheckBoxRow(
                      height: 40,
                      isChecked: thirdSelected,
                      onPressed: (value) {
                        if(secondSelected){
                          secondSelected = false;
                        }
                        setState(() {
                          thirdSelected = value;
                        });
                      },
                      child: Text(AppTexts.partnerPerson),
                    ),
                
                    const Divider(),
                
                    CheckBoxRow(
                        isChecked: fourthSelected,
                        onPressed: (value) {
                          setState(() {
                            fourthSelected = value;
                          });
                        },
                        child: RichText(
                          text: TextSpan(
                            text: AppTexts.iAccept,
                            style: const TextStyle(color: Colors.black,fontSize: 14),
                            children: [
                              TextSpan(
                                text: AppTexts.approval,
                                style: TextStyle(color: AppColors.secondaryBlueDarker),
                                recognizer: TapGestureRecognizer()..onTap = () {
                
                                },
                              ),
                              TextSpan(
                                text: AppTexts.forPersonalData,
                                style: const TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: AppTexts.privacyPolicy,
                                style: TextStyle(color: AppColors.secondaryBlueDarker),
                                recognizer: TapGestureRecognizer()..onTap = () {
                                },
                              ),
                            ],
                          ),
                        )
                    ),
                
                
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar:Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: (){
                  context.pop();
                },
                child: Text(AppTexts.alreadyHaveAccount,
                  style: TextStyle(color: AppColors.secondaryBlueDarker),)
            ),
            const SizedBox(height: 10,),
            ExpandedButton(
                child: Text(AppTexts.next,style: const TextStyle(color: Colors.white),),
                onPressed: (){

                  if(!(firstSelected || secondSelected)){
                    AppToast.showToast(AppTexts.chooseOne);
                  }else if(!fourthSelected){
                    AppToast.showToast(AppTexts.acceptDataAnalysis);
                  }else{
                    registrationPageCubit.registrationUser(
                      '${nameController.text} ${surnameController.text}', phoneController.text, iinController.text,
                      thirdSelected, firstSelected ? ClientType.BUSINESS : ClientType.INDIVIDUAL
                    );
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}


