import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/currency_symbol.dart';
import 'package:web_com/data/repository/file_repository.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_office_cubit/review_office_cubit.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile.dart';
import 'package:web_com/widgets/shimmer_box.dart';
import 'package:web_com/widgets/status_box.dart';

import '../../../config/app_box_decoration.dart';
import '../../../config/app_icons.dart';
import '../../../domain/client_contract_service.dart';
import '../../../widgets/common_tab_bar.dart';
import '../../../widgets/deposit_card.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import 'cabinet_parts/cabinet_part.dart';
import 'cabinet_parts/operation_part.dart';

class ReviewOffice extends StatefulWidget {
  const ReviewOffice({super.key});

  @override
  State<ReviewOffice> createState() => _ReviewOfficeState();
}

class _ReviewOfficeState extends State<ReviewOffice> {

  int selected = 0;
  TextEditingController controller = TextEditingController();

  bool focused = false;

  final _tabs = const [
    Tab(text: 'Кабинеты'),
    Tab(text: 'Зачисление'),
  ];

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller,isFocused: (value) {
        setState(() {
          focused = value;
        });
      },),
      body: focused ? const FilterFocused():Column(
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
            CabinetPart(navigationPageCubit: navigationPageCubit, query: '',),
          if(selected == 1)
            OperationPart(navigationPageCubit: navigationPageCubit,)
        ],
      ),

      floatingActionButton: selected == 1 ? FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        heroTag: 'addChanges',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: false,
        onPressed: () { context.push('/newOperation'); },
        child: SvgPicture.asset(AppIcons.addContract),
      ) : null,
    );
  }
}




class FilterFocused extends StatelessWidget {
  const FilterFocused({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Сортировать',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    StatusBox(color: AppColors.secondaryBlueDarker, text: 'по названию'),
                    const SizedBox(width: 5,),
                    StatusBox(color: AppColors.secondaryBlueDarker, text: 'по названию'),
                    const SizedBox(width: 5,),
                    StatusBox(color: AppColors.secondaryBlueDarker, text: 'по названию'),
                  ],
                ),
                const SizedBox(height: 10,),
                const Text('Операции',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    StatusBox(color: AppColors.secondaryBlueDarker, text: 'все'),
                    const SizedBox(width: 5,),
                    StatusBox(color: AppColors.secondaryBlueDarker, text: 'все'),
                    const SizedBox(width: 5,),
                    StatusBox(color: AppColors.secondaryBlueDarker, text: 'все'),
                  ],
                ),
                const SizedBox(height: 10,),
                const Text('Рекламные кабинеты',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
              ],
            ),
          ),

          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 160/40
              ),
              itemCount: 8,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: AppBoxDecoration.boxWithShadow,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: Image.asset('assets/images/vk.png'),
                      ),
                      const SizedBox(width: 5,),
                      Text('Реклама Vk',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondaryGreyDarker),)
                    ],
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
