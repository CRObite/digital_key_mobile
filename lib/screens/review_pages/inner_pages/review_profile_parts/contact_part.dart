
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../../../config/app_box_decoration.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_icons.dart';
import '../../../../config/app_texts.dart';
import '../../../../domain/contacts_card_info.dart';
import '../../../../widgets/check_box_row.dart';

class ContactPart extends StatelessWidget {
  const ContactPart({super.key, required this.listOfInfo, required this.deleteContract, required this.contactPersonChange, required this.addNew});

  final List<ContactsCardInfo> listOfInfo;
  final Function(int) deleteContract;
  final Function(int, bool) contactPersonChange;
  final VoidCallback addNew;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: listOfInfo.isNotEmpty ? ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: listOfInfo.length,
          itemBuilder: (context, index){

            return Container(
              margin: EdgeInsets.only(bottom: index != listOfInfo.length - 1 ?  10: 80),
              width: double.infinity,
              decoration: AppBoxDecoration.boxWithShadow,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  TitledField(controller: listOfInfo[index].nameController, title: AppTexts.fullName, type: TextInputType.text,important: true,),
                  const SizedBox(height: 10,),
                  TitledField(controller: listOfInfo[index].phoneController, title: AppTexts.phoneNumber, type: TextInputType.phone,important: true,),
                  const SizedBox(height: 10,),
                  TitledField(controller: listOfInfo[index].emailController, title: AppTexts.email, type: TextInputType.emailAddress,important: true,),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: CheckBoxRow(
                          height: 30,
                          isChecked: listOfInfo[index].contactPerson,
                          onPressed: (value) {
                            contactPersonChange(index,value);
                          },
                          child: Text(AppTexts.contactPerson,style: const TextStyle(fontSize: 12),),
                        ),
                      ),

                      IconButton(onPressed: (){deleteContract(index);}, icon: SvgPicture.asset(AppIcons.delete))
                    ],
                  ),
                ],
              ),
            );
          }
      ): const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(child: Text('Контактов нет, его можно добавить нажав на иконку ниже',textAlign: TextAlign.center,),),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () { addNew(); },
        child: SvgPicture.asset(AppIcons.addContact),
      ),

    );
  }
}