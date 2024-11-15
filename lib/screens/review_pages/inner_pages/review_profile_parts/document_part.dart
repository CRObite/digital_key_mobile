import 'package:flutter/material.dart';

import '../../../../widgets/file_picker_container.dart';

class DocumentPart extends StatelessWidget {
  const DocumentPart({super.key, required this.govFileName, required this.requisiteFileNames, required this.orderFileName, required this.ndsFileName, required this.filePicked, required this.stateDocError, required this.requisitesError});

  final String? govFileName;
  final String? requisiteFileNames;
  final String? orderFileName;
  final String? ndsFileName;
  final Function(int,String) filePicked;
  final String stateDocError;
  final String requisitesError;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
        
            FilePickerContainer(
              onPressed: (value) async {
                filePicked(0,value);
              },
              title: 'Справка о государственной регистрации',
              important: true,
              fileName: govFileName,
              deletePressed: () {
        
              },
              errorText: stateDocError,
            ),
            const SizedBox(height: 10,),
            FilePickerContainer(
              onPressed: (value) async {
                filePicked(1,value);
              },
              title: 'Реквизиты',
              important: true,
              fileName: requisiteFileNames,
              deletePressed: () {
        
              },
              errorText:  requisitesError,
            ),
            const SizedBox(height: 10,),
            FilePickerContainer(
              onPressed: (value) async {
                filePicked(2,value);
              },
              title: 'Приказ',
              important: true,
              fileName: orderFileName,
              deletePressed: () {
        
              },
            ),
            const SizedBox(height: 10,),
            FilePickerContainer(
              onPressed: (value) async {
                filePicked(3,value);
              },
              title: 'Свидетельство о НДС',
              important: false,
              fileName: ndsFileName,
              deletePressed: () {
        
              },

            ),
          ],
        ),
      ),
    );
  }
}
