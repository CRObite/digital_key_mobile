

import 'package:flutter/material.dart';

import '../../../../widgets/check_box_row.dart';
import '../../../../widgets/titled_field.dart';

class AddressPart extends StatelessWidget {
  const AddressPart({super.key, required this.realAddressController, required this.addressController, required this.realAddressError, required this.addressError});

  final TextEditingController realAddressController;
  final String realAddressError;
  final TextEditingController addressController;
  final String addressError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TitledField(controller: addressController, title: 'Юридический адрес', type: TextInputType.text,errorText: addressError,important: true,),
          const SizedBox(height: 20,),
          TitledField(controller: realAddressController, title: 'Фактический адрес', type: TextInputType.text,errorText: realAddressError,important: true,),
          CheckBoxRow(
              isChecked: addressController.text == realAddressController.text && addressController.text.isNotEmpty,
              onPressed: (value) {

              },
              child: const Text('Совпадает с юридическим',style: TextStyle(fontSize: 12),)
          ),

        ],
      ),
    );
  }
}
