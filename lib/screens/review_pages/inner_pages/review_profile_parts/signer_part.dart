

import 'package:flutter/material.dart';

import '../../../../config/signer_type_enum.dart';
import '../../../../domain/position.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/file_picker_container.dart';
import '../../../../widgets/titled_field.dart';

class SignerPart extends StatelessWidget {
  const SignerPart({super.key, required this.nameController, this.selectedSignerType, required this.fileName, required this.positionList, this.selectedPosition, required this.positionSelected, required this.signerTypeSelected, required this.filePicked, required this.deleteFile});

  final TextEditingController nameController;
  final SignerType? selectedSignerType;
  final String? fileName;
  final List<Position> positionList;
  final Position? selectedPosition;
  final Function(Position) positionSelected;
  final Function(SignerType) signerTypeSelected;
  final Function(String) filePicked;
  final VoidCallback deleteFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TitledField(controller: nameController, title: 'ФИО', type: TextInputType.text,important: true,),
            const SizedBox(height: 10,),
            CustomDropDown(title: 'Должность', dropDownList: positionList.map((position) => position.name).toList(),
              onSelected: (value){
                positionSelected(positionList.firstWhere((position) => position.name == value));
              },
              selectedItem: selectedPosition?.name,
              important: true,
            ),
            const SizedBox(height: 10,),
            CustomDropDown(title: 'На основании', dropDownList: getSignerTypeDescriptions(),
              onSelected: (value){
                signerTypeSelected(getSignerTypeByDescription(value)!);
              },
              selectedItem: selectedSignerType?.description,
              important: true,
            ),
            const SizedBox(height: 10,),
            FilePickerContainer(
              onPressed: (value) async {
                filePicked(value);
              },
              title: 'файл-основание',
              important: true,
              fileName: fileName,
              deletePressed: () {
                deleteFile();
              },
            ),
        
          ],
        ),
      ),
    );
  }
}

