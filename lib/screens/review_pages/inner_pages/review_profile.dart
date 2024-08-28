
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile_cubit/review_profile_cubit.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/status_box.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../../config/app_texts.dart';
import '../../authorization_pages/registration_page.dart';

class ReviewProfile extends StatefulWidget {
  const ReviewProfile({super.key});

  @override
  State<ReviewProfile> createState() => _ReviewProfileState();
}

class _ReviewProfileState extends State<ReviewProfile> {

  int currentPosition = 0;

  ReviewProfileCubit reviewProfileCubit = ReviewProfileCubit();

  TextEditingController nameController = TextEditingController();
  TextEditingController iinController = TextEditingController();

  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    reviewProfileCubit.getClientData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => reviewProfileCubit,
      child: BlocListener<ReviewProfileCubit,ReviewProfileState>(
        listener: (context, state){
          if(state is ReviewProfileSuccess){

            setState(() {
              nameController.text = state.client.name ?? '';
              iinController.text = state.client.binIin ?? '';
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameController.text,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15,),
                  const StatusBox(color: Color(0xffEAB308), text: 'Дней до удаление: 6')

                ],
              ),
            ),

            SizedBox(
              height: 50,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  final isSelected = currentPosition == index;

                  return AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(vertical: isSelected ? 0 : 5),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.only(right: index != 2 ? 10 : 0),
                      width: isSelected ? MediaQuery.of(context).size.width * 0.35 : MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.secondaryBlueDarker : AppColors.mainBlue,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSelected ? 14 : 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        child: Align( alignment:  Alignment.centerLeft,child: Text(
                            index == 0 ? AppTexts.client :
                            index == 1 ? AppTexts.contacts:
                            AppTexts.contract
                        )
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPosition = index;
                    // Animate the scroll of the ListView to the selected position
                    _scrollController.animateTo(
                      index * MediaQuery.of(context).size.width * 0.6,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  });
                },
                children: [
                  ClientPart(nameController: nameController, iinController: iinController, onEditPressed: () {  }, onSavePressed: () {  },),
                  const ContactPart(),
                  const ContractPart()
                ],
              ),
            ),


          ],
        )
      ),
    );
  }
}



class ClientPart extends StatelessWidget {
  const ClientPart({super.key, required this.nameController, required this.iinController, required this.onEditPressed, required this.onSavePressed});

  final TextEditingController nameController;
  final TextEditingController iinController;
  final VoidCallback onEditPressed;
  final VoidCallback onSavePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TitledField(controller: nameController, title: AppTexts.counterAgentName, type: TextInputType.text),
            const SizedBox(height: 10,),
            TitledField(controller: iinController, title: AppTexts.iin, type: TextInputType.text),
            const SizedBox(height: 25,),
            Row(
              children: [

                Flexible(
                  flex: 1,
                  child: ExpandedButton(
                    innerPaddingY: 12,
                    backgroundColor: Colors.white,
                    sideColor: AppColors.secondaryBlueDarker,
                    onPressed: () { onSavePressed(); },
                    child: Text(AppTexts.saveDraft,style: TextStyle(color: AppColors.mainBlue,fontSize: 12),),
                  ),
                ),

                const SizedBox(width: 10,),

                Flexible(
                  flex: 1,
                  child: ExpandedButton(
                    innerPaddingY: 12,
                    onPressed: () { onEditPressed(); },
                    child: Text(AppTexts.saveEdit,style: const TextStyle(color: Colors.white,fontSize: 12),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ContactPart extends StatefulWidget {
  const ContactPart({super.key});

  @override
  State<ContactPart> createState() => _ContactPartState();
}

class _ContactPartState extends State<ContactPart> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.borderGrey),
                        borderRadius: const BorderRadius.all(Radius.circular(12))
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        TitledField(controller: nameController, title: 'ФИО', type: TextInputType.text),
                        const SizedBox(height: 10,),
                        TitledField(controller: phoneController, title: 'Номер телефона', type: TextInputType.phone),
                        const SizedBox(height: 10,),
                        TitledField(controller: emailController, title: 'Электронная почта', type: TextInputType.emailAddress),
                        const SizedBox(height: 10,),
                        CheckBoxRow(
                          height: 30,
                          isChecked: selected,
                          onPressed: (value) {
                            setState(() {
                              selected = !selected;
                            });
                          },
                          child: const Text('Контактное лицо',style: TextStyle(fontSize: 12),),
                        ),
                        const SizedBox(height: 15,),

                        Row(
                          children: [

                            Flexible(
                              flex: 1,
                              child: ExpandedButton(
                                innerPaddingY: 12,
                                backgroundColor: Colors.white,
                                sideColor: Colors.red,
                                onPressed: () { },
                                child: const Text('Удалить контакт',style: TextStyle(color: Colors.red,fontSize: 12),),
                              ),
                            ),

                            const SizedBox(width: 10,),

                            Flexible(
                              flex: 1,
                              child: ExpandedButton(
                                innerPaddingY: 12,
                                onPressed: () {  },
                                child: Text(AppTexts.saveEdit,style: const TextStyle(color: Colors.white,fontSize: 12),),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }
            ),

            const SizedBox(height: 15,),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ExpandedButton(
                innerPaddingY: 12,
                onPressed: () {},
                child: const Text('Добавить контакт',style: TextStyle(color: Colors.white,fontSize: 12),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class ContractPart extends StatelessWidget {
  const ContractPart({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index){
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.borderGrey),
                    borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatusBox(color: Colors.green, text: 'Активный'),
                      SizedBox(height: 5,),
                      Text('Договор “32255-КД-Б”',style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      DoubleTextColumn(text: 'Клиент', text2: 'Тест',),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DoubleTextColumn(text: 'Дата договора', text2: '16/08/2021',),
                                DoubleTextColumn(text: 'Дата окончания', text2: '16/08/2022',),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DoubleTextColumn(text: 'Форма валюта', text2: 'USD',),
                                DoubleTextColumn(text: 'Организация', text2: 'Digital Zone',),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
            ),

            const SizedBox(height: 15,),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ExpandedButton(
                innerPaddingY: 12,
                onPressed: () {},
                child: Text(AppTexts.createContract,style: const TextStyle(color: Colors.white,fontSize: 12),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}



class DoubleTextColumn extends StatelessWidget {
  const DoubleTextColumn({super.key, required this.text, required this.text2});

  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style: TextStyle(fontSize: 12, color: AppColors.mainGrey),),
        Text(text2,style: const TextStyle(fontSize: 12),),
      ],
    );
  }
}
