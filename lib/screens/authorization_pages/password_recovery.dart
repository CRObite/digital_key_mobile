import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/screens/authorization_pages/password_recovery_cubit/password_recovery_cubit.dart';

import '../../config/app_texts.dart';
import '../../config/app_toast.dart';
import '../../widgets/expanded_button.dart';
import '../../widgets/titled_field.dart';
import '../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {

  TextEditingController emailController = TextEditingController();
  PasswordRecoveryCubit passwordRecoveryCubit =PasswordRecoveryCubit();
  String? errorText;

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: IconButton(
            onPressed: () { context.pop(); },
            icon: const Icon(Icons.arrow_back_ios_new_rounded,size: 18,),
          )
      ),
      body: BlocProvider(
        create: (context) => passwordRecoveryCubit,
        child: BlocListener<PasswordRecoveryCubit,PasswordRecoveryState>(
          listener: (context,state){
            if(state is PasswordRecoverySuccess){

              navigationPageCubit.showMessage(AppTexts.newPasswordWasSend, true);
              context.goNamed('loginPage');

            }

            if(state is PasswordRecoveryError){
              setState(() {
                errorText = state.errorText;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppTexts.passwordRecovering,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      TitledField(
                        controller: emailController,
                        title: AppTexts.email,
                        type: TextInputType.text,
                        errorText: errorText,
                      ),
                      const SizedBox(height: 10,),
                      Text(AppTexts.passwordRecoveryDescription,style: const TextStyle(fontSize: 12),),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar:Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30, top: 250),
        child: ExpandedButton(
            child: Text(AppTexts.send,style: const TextStyle(color: Colors.white),),
            onPressed: (){passwordRecoveryCubit.recoverPassword(context,emailController.text);}
        ),
      ),
    );
  }
}
