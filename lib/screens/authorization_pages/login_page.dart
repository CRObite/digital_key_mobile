
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/app_texts.dart';
import 'package:web_com/screens/authorization_pages/login_page_cubit/login_page_cubit.dart';
import 'package:web_com/widgets/expanded_button.dart';

import '../../widgets/alternative_entering_buttons.dart';
import '../../widgets/titled_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginPageCubit loginPageCubit = LoginPageCubit();

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => loginPageCubit,
        child: BlocListener<LoginPageCubit,LoginPageState>(
          listener: (context, state){

            if(state is LoginPageError){
              setState(() {
                errorText = state.errorText;
              });
            }
            if(state is LoginPageSuccess){
              context.go('/reviewStatistics');
            }

          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppTexts.enter,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      TitledField(
                          controller: loginController,
                          title: AppTexts.login,
                          type: TextInputType.emailAddress
                      ),
                      const SizedBox(height: 10,),
                      TitledField(
                          controller: passwordController,
                          title: AppTexts.password,
                          type: TextInputType.visiblePassword
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          errorText.isNotEmpty ? Flexible(
                            child: Text(
                              errorText,
                              style: const TextStyle(fontSize: 12,color: Colors.red),
                            ),
                          ): const SizedBox(width: 2,),

                          TextButton(
                              onPressed: (){context.goNamed('passwordRecovery');},
                              child: Text(AppTexts.forgotPassword,
                                style: TextStyle(fontSize: 12,color: AppColors.secondaryBlueDarker),)
                          )
                        ],
                      )
                    ],
                  ),
                ),

                ExpandedButton(
                    child: Text(AppTexts.enter,style: const TextStyle(color: Colors.white),),
                    onPressed: (){loginPageCubit.loginUser(loginController.text, passwordController.text);}
                ),
                const SizedBox(height: 20,),

                AlternativeEnteringButtons(onPressed: (value) {
                    loginPageCubit.startAuth(value);
                  },
                )
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar:Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30),
        child: ExpandedButton(
            child: Text(AppTexts.registration,style: const TextStyle(color: Colors.white),),
            onPressed: (){
              context.goNamed('registrationPage');
            }
        ),
      ),
    );
  }
}

