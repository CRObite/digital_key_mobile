import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_toast.dart';
import 'package:web_com/screens/authorization_pages/registration_second_page_cubit/registration_second_page_cubit.dart';

import '../../config/app_texts.dart';
import '../../widgets/alternative_entering_buttons.dart';
import '../../widgets/expanded_button.dart';
import '../../widgets/titled_field.dart';
import '../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class RegistrationSecondPage extends StatefulWidget {
  const RegistrationSecondPage({super.key,
    required this.name,
    required this.phone,
    required this.iin,
    required this.partner,
    required this.type}
  );

  final String name;
  final String phone;
  final String iin;
  final bool partner;
  final String type;

  @override
  State<RegistrationSecondPage> createState() => _RegistrationSecondPageState();
}

class _RegistrationSecondPageState extends State<RegistrationSecondPage> {

  TextEditingController emailController = TextEditingController();
  RegistrationSecondPageCubit registrationSecondPageCubit = RegistrationSecondPageCubit();

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
        create: (context) => registrationSecondPageCubit,
        child: BlocListener<RegistrationSecondPageCubit,RegistrationSecondPageState>(
          listener: (context,state){
            if(state is RegistrationSecondPageSuccess){

              navigationPageCubit.showMessage('Пароль был отправлен на вашу почту', true);

              if(state.byProvider){
                context.goNamed('reviewStatistics');
              }else{
                context.goNamed('loginPage');
              }


            }
            if(state is RegistrationSecondPageError){
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
                Text(AppTexts.post,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
                    ],
                  ),
                ),

                AlternativeEnteringButtons(onPressed: (value) {
                  registrationSecondPageCubit.startAuth(context,value, widget.name, widget.phone, widget.iin, widget.partner, widget.type);
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar:Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30, top: 250),
        child: ExpandedButton(
            child: Text(AppTexts.registration,style: const TextStyle(color: Colors.white),),
            onPressed: (){registrationSecondPageCubit.registrationUser(context,widget.name, widget.phone, emailController.text, widget.iin, widget.partner, widget.type);}
        ),
      ),
    );
  }
}
