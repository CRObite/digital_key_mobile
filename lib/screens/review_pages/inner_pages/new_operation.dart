import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/config/app_box_decoration.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/widgets/custom_drop_down.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../../config/app_icons.dart';
import '../../../widgets/go_back_row.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class NewOperation extends StatefulWidget {
  const NewOperation({super.key});

  @override
  State<NewOperation> createState() => _NewOperationState();
}

class _NewOperationState extends State<NewOperation> {
  TextEditingController textController =TextEditingController();
  TextEditingController textController2 =TextEditingController();

  List<String> values = ['Основной счет','Google Реклама','Яндекс директ','Meta','Вконтакте'];
  List<String> values2 = ['title1','title2','title3','title4',];
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: textController, isFocused: (value ) {  },),

      body: Column(
        children: [
          const GoBackRow(title: 'Новое зачислений'),

          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: AppBoxDecoration.boxWithShadow,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  CustomDropDown(title: 'Счет', important: false, dropDownList: const [], onSelected: (value){}),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Остаток на счете', style: TextStyle(color: AppColors.mainGrey, fontSize: 12),),
                      const SizedBox(width: 5,),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/ic_money.svg'),
                          const SizedBox(width: 5,),
                          const Text('440',style: TextStyle(fontSize: 12),),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  TitledField(controller: textController2, title: 'Списать', type: TextInputType.number, hint: 'Введите сумму',),
                  const SizedBox(height: 15,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(child: Divider(color: AppColors.borderGrey,)),
                          const SizedBox(width: 10,),
                          SvgPicture.asset('assets/icons/ic_swap.svg'),
                          const SizedBox(width: 10,),
                          Expanded(child: Divider(color: AppColors.borderGrey,)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),

                  CustomDropDown(title: 'Счет', important: false, dropDownList: const [], onSelected: (value){}),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Остаток на счете', style: TextStyle(color: AppColors.mainGrey, fontSize: 12),),
                      const SizedBox(width: 5,),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/ic_money.svg'),
                          const SizedBox(width: 5,),
                          const Text('440',style: TextStyle(fontSize: 12),),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  TitledField(controller: textController2, title: 'Получить', type: TextInputType.number, hint: 'Нут курса',),
                  const SizedBox(height: 15,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ExpandedButton(
                      innerPaddingY: 10,
                        child: const Text('Перевести', style: TextStyle(color: Colors.white),),
                        onPressed: (){}
                    ),
                  ),


                ],
              ),
            ),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () {},
        child: SvgPicture.asset('assets/icons/ic_add_wallet.svg'),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
        child: ExpandedButton(
            child: const Text('Перевести все', style: TextStyle(color: Colors.white),),
            onPressed: (){}
        ),
      ),
    );
  }
}
