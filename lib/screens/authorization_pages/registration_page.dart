import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_colors.dart';
import '../../config/app_texts.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                  ),
                  const SizedBox(height: 10,),
                  TitledField(
                      controller: surnameController,
                      title: AppTexts.surname,
                      type: TextInputType.text
                  ),
                  const SizedBox(height: 10,),
                  TitledField(
                      controller: phoneController,
                      title: AppTexts.phone,
                      type: TextInputType.phone
                  ),
                  const SizedBox(height: 10,),
                  TitledField(
                      controller: iinController,
                      title: AppTexts.iin,
                      type: TextInputType.number
                  ),
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
                  text: 'Я даю ',
                  style: const TextStyle(color: Colors.black,fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'согласие',
                      style: TextStyle(color: AppColors.secondaryBlueDarker),
                      recognizer: TapGestureRecognizer()..onTap = () {

                      },
                    ),
                    const TextSpan(
                      text: ' на обработку моих персональных данных в соответствии с ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Политикой конфиденциальности',
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
                onPressed: (){context.goNamed('registrationSecondPage');}
            ),
          ],
        ),
      ),
    );
  }
}


class CheckBoxRow extends StatelessWidget {
  const CheckBoxRow({super.key,required this.isChecked, required this.onPressed, required this.child, this.height});

  final Widget child;
  final bool isChecked;
  final Function(bool) onPressed;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Checkbox(
            side: const BorderSide(width: 1, color: Color(0xff616161)),
            activeColor: AppColors.secondaryBlueDarker,
              value: isChecked,
              onChanged: (value){
            if(value!= null){
              onPressed(value);
            }
          }),

          Flexible(child: child)
        ],
      ),
    );
  }
}
