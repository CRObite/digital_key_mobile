import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_box_decoration.dart';
import 'package:web_com/config/app_icons.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile.dart';
import 'package:web_com/widgets/custom_drop_down.dart';
import 'package:web_com/widgets/expanded_button.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_texts.dart';
import '../../../widgets/common_tab_bar.dart';

class StatisticDetails extends StatefulWidget {
  const StatisticDetails({super.key});

  @override
  State<StatisticDetails> createState() => _StatisticDetailsState();
}

class _StatisticDetailsState extends State<StatisticDetails> {

  int selected = 0;
  int currentPosition = 0;

  int touchedIndex = -1;

  List<double> values = [20, 10, 12, 40, 10, 30, 80, 90, 40, 20, 34, 47];

  final _tabs = [
    const Tab(icon: Icon(CupertinoIcons.chart_pie),),
    const Tab(icon: Icon(CupertinoIcons.graph_square),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          context.pop();},
          icon: const Icon(Icons.arrow_back_ios_new,size: 15,)
        ),
        title: const Align(alignment: Alignment.center,child: Text('Google Ads',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))),
      ),
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


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomDropDown(title: 'Кабинеты', important: false, dropDownList: const [], onSelected: (value){}, withoutTitle: true, withShadow: true,),
          ),

          Container(
            margin: const EdgeInsets.all(20),
            decoration: AppBoxDecoration.boxWithShadow,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    PartColumn(
                      isSelected: currentPosition == 0,
                      title: 'День',
                      onSelected: () {
                        setState(() {
                          currentPosition = 0;
                        });
                      },
                    ),
                    PartColumn(
                      isSelected: currentPosition == 1,
                      title: 'Неделя',
                      onSelected: () {
                        setState(() {
                          currentPosition = 1;
                        });
                      },
                    ),
                    PartColumn(
                      isSelected: currentPosition == 2,
                      title: 'Месяц',
                      onSelected: () {
                        setState(() {
                          currentPosition = 2;
                        });
                      },
                    ),

                    SvgPicture.asset(AppIcons.calendar)
                  ],
                ),

                const SizedBox(height: 20,),

                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  padding: const EdgeInsets.all(10),
                  child: PieChart(
                    PieChartData(
                      sections:List.generate(
                        12, // Number of sections
                            (index) {

                          return PieChartSectionData(
                            value: values[index],
                            radius: touchedIndex == index ? 80: 60,
                            titlePositionPercentageOffset: 1.2,
                            title: '${values[index]}',
                            badgeWidget: touchedIndex == index
                                ? Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: AppColors.secondaryBlueDarker,
                                    border: Border.all(
                                        color:
                                        Colors.white),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text('${values[index]}', style: const TextStyle(color: Colors.white),)
                            ) : null,
                          );
                        },
                      ),
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {

                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                ExpandedButton(
                  innerPaddingY: 5,
                  sideColor: AppColors.secondaryBlueDarker,
                    backgroundColor: Colors.white,
                    onPressed: (){},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Клики', style: TextStyle(color: AppColors.mainGrey),),
                            const SizedBox(width: 5,),
                            Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.mainGrey,)
                          ],
                        ),
                        Text('54 558', style: TextStyle(fontSize: 20, color: AppColors.secondaryBlueDarker),)
                      ],
                    )
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
