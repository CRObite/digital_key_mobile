import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_texts.dart';
import '../../widgets/expanded_button.dart';
import '../../widgets/titled_field.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: IconButton(
            onPressed: () { context.pop(); },
            icon: const Icon(Icons.arrow_back_ios_new_rounded,size: 18,),
          )
      ),
      body: Padding(
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
                  ),
                  const SizedBox(height: 10,),
                  Text(AppTexts.passwordRecoveryDescription,style: const TextStyle(fontSize: 12),),
                ],
              ),
            ),

          ],
        ),
      ),

      bottomNavigationBar:Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30, top: 250),
        child: ExpandedButton(
            child: Text(AppTexts.send,style: const TextStyle(color: Colors.white),),
            onPressed: (){}
        ),
      ),
    );
  }
}
