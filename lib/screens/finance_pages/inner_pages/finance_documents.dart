import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/config/app_box_decoration.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile.dart';
import 'package:web_com/widgets/status_box.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_icons.dart';
import '../../../config/app_shadow.dart';
import '../../../widgets/common_tab_bar.dart';

class FinanceDocuments extends StatefulWidget {
  const FinanceDocuments({super.key});

  @override
  State<FinanceDocuments> createState() => _FinanceDocumentsState();
}

class _FinanceDocumentsState extends State<FinanceDocuments> {

  List<bool> selectedValues = [false,false,false,false,false,false];

  bool selectingStarted = false;

  final _tabs = const [
    Tab(text: 'Счет'),
    Tab(text: 'ЭСФ'),
    Tab(text: 'АВР'),
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CommonTabBar(tabs: _tabs, onPressed: (value){
              setState(() {
                selected = value;
              });
            }),
          ),

          if(selected == 0)
            Expanded(
              child: ListView.builder(
                  itemCount: selectedValues.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onLongPress: (){
                        if(!selectingStarted){
                          setState(() {
                            selectedValues[index] = !selectedValues[index];
                            selectingStarted = true;
                          });
                        }
                      },
                      onTap: (){
                        if(selectingStarted){
                          setState(() {
                            selectedValues[index] = !selectedValues[index];
                            if(selectedValues.every((element) => element == false)){
                              selectingStarted = false;
                            }
                          });
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: AppShadow.shadow,
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            border: selectedValues[index] ? Border.all(width: 1, color: AppColors.mainBlue): null,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StatusBox(color: AppColors.mainBlue, text: 'Выставлен'),
                                  const SizedBox(height: 10,),
                                  const Text('Счет KZ240000543',style: TextStyle(fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 15,),
                                  const DoubleTextColumn(text: 'Договор', text2: '12242022-СУ_12.12.2022'),
                                  const SizedBox(height: 10,),
                                  const Row(
                                    children: [
                                      Expanded(child: DoubleTextColumn(text: 'Сумма', text2: '540 000.00 ₸')),
                                      SizedBox(width: 10,),
                                      Expanded(child: DoubleTextColumn(text: 'Дата выставления', text2: '08.02.2024')),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: (){},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xffEBF4FC),
                                        borderRadius: BorderRadius.all(Radius.circular(6))
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: SvgPicture.asset('assets/icons/ic_download.svg'),
                                    ),
                                  ),
                                  const SizedBox(height: 10,),
                                  IconButton(onPressed: (){}, icon: SvgPicture.asset('assets/icons/ic_delete.svg'))

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
          if(selected == 1)
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context,index){
                    return const Text('asdasda');
                  }
              ),
            ),
          if(selected == 2)
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context,index){
                    return const Text('asdasda');
                  }
              ),
            )

        ],
      ),
      floatingActionButton: selected != 0 ? FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () {  },
        child: SvgPicture.asset(AppIcons.addContract),
      ): selectingStarted ? FloatingActionButton(
        backgroundColor: Colors.red.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: false,
        onPressed: () {  },
        child: SvgPicture.asset(AppIcons.delete, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),),
      ): null,

    );
  }
}
