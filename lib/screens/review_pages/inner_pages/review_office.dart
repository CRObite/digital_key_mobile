import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/app_shadow.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile.dart';
import 'package:web_com/widgets/status_box.dart';

import '../../../config/app_box_decoration.dart';
import '../../../config/app_icons.dart';
import '../../../widgets/common_tab_bar.dart';
import '../../../widgets/deposit_card.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class ReviewOffice extends StatefulWidget {
  const ReviewOffice({super.key});

  @override
  State<ReviewOffice> createState() => _ReviewOfficeState();
}

class _ReviewOfficeState extends State<ReviewOffice> {

  final List<ScrollController> _scrollControllers = [];
  final int _rowCount = 7;
  int selected = 0;
  TextEditingController controller = TextEditingController();

  bool focused = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _rowCount; i++) {
      final controller = ScrollController();
      controller.addListener(() => _syncScroll(controller));
      _scrollControllers.add(controller);
    }
  }

  void _syncScroll(ScrollController scrolledController) {
    final scrollOffset = scrolledController.hasClients
        ? scrolledController.offset
        : 0.0;

    for (final controller in _scrollControllers) {
      if (controller != scrolledController && controller.hasClients && controller.offset != scrollOffset) {
        controller.jumpTo(scrollOffset);
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: double.infinity,
              decoration: AppBoxDecoration.boxWithShadow,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _rowCount,
                    itemBuilder: (context,index){
                      return Row(
                        children: [
                          InkWell(
                            onTap:(){
                              context.push('/cabinetDetails');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.38,
                              decoration: const BoxDecoration(
                                  color: Color(0xffF9FAFB),
                              ),
                                padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Название аккаунта', style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 5,),
                                  Row(
                                    children: [

                                      SizedBox(width: 18,height: 18,
                                        child: Image.asset('assets/images/vk.png'),
                                      ),
                                      const SizedBox(width: 5,),
                                      Flexible(child: Text('Реклама VK', style: TextStyle(fontSize: 12,color: AppColors.secondaryGreyDarker),)),
                                    ],
                                  )
                                ],
                              )
                            ),
                          ),

                          Expanded(
                            child: index == _rowCount - 1 ? Scrollbar(
                              controller: _scrollControllers[index],
                              thumbVisibility: true,
                              child: ScrollableRow(controller: _scrollControllers[index],)
                            ) : ScrollableRow(controller: _scrollControllers[index],)
                          )

                        ],
                      );
                    }
                ),
              )
            ),
          ),

          if(selected == 1)
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 10,
                  itemBuilder: (context,index){
                    return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const DepositCard()
                    );
                  }
              ),
            )
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


class ScrollableRow extends StatelessWidget {
  const ScrollableRow({super.key, required this.controller});

  final ScrollController controller;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const DoubleTextColumn(text: 'ID аккаунта ', text2: 'ID аккаунта',gap: 5,),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const DoubleTextColumn(text: 'Сайт', text2: 'Сайт',gap: 5,),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const DoubleTextColumn(text: 'Остаток на аккаунте', text2: '860,82 \$',gap: 5,),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const DoubleTextColumn(text: 'Потрачено с начало месяца', text2: '265,58 \$',gap: 5,),
          ),
        ],
      ),
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
