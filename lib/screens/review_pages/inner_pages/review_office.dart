import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/app_shadow.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile.dart';

import '../../../config/app_box_decoration.dart';
import '../../../config/app_icons.dart';
import '../../../widgets/common_tab_bar.dart';
import '../../../widgets/deposit_card.dart';

class ReviewOffice extends StatefulWidget {
  const ReviewOffice({super.key});

  @override
  State<ReviewOffice> createState() => _ReviewOfficeState();
}

class _ReviewOfficeState extends State<ReviewOffice> {

  final List<ScrollController> _scrollControllers = [];
  final int _rowCount = 7;
  int selected = 0;

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
