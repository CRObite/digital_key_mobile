import 'package:flutter/material.dart';

import '../../../../config/app_texts.dart';
import '../../../../widgets/titled_field.dart';

class ClientPart extends StatelessWidget {
  const ClientPart({super.key, required this.nameController, required this.iinController, required this.nameFieldError, required this.iinFieldError});

  final TextEditingController nameController;
  final String nameFieldError;
  final TextEditingController iinController;
  final String iinFieldError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TitledField(controller: nameController, title: AppTexts.counterAgentName, type: TextInputType.text,errorText: nameFieldError,important: true,),
          const SizedBox(height: 10,),
          TitledField(controller: iinController, title: AppTexts.iin, type: TextInputType.text,errorText: iinFieldError,important: true,),
          const SizedBox(height: 25,),
        ],
      ),
    );
  }
}