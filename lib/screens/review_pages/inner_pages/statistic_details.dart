import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:web_com/config/app_box_decoration.dart';
import 'package:web_com/config/app_formatter.dart';
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
  final List<Map<DateTime, double>> data = [
    {DateTime(2024, 1, 1): 95.5},
    {DateTime(2024, 1, 2): 120.0},
    {DateTime(2024, 1, 4): 125.0},
    {DateTime(2024, 1, 6): 115.5},
    {DateTime(2024, 1, 8): 100.0},
    {DateTime(2024, 1, 10): 130.0},
    {DateTime(2024, 1, 12): 110.0},
    {DateTime(2024, 1, 14): 105.0},
    {DateTime(2024, 1, 16): 125.5},
    {DateTime(2024, 1, 18): 95.0},
    {DateTime(2024, 1, 20): 120.5},
    {DateTime(2024, 1, 22): 90.5},
    {DateTime(2024, 1, 24): 105.5},
    {DateTime(2024, 1, 26): 100.0},
    {DateTime(2024, 1, 30): 115.0},

    {DateTime(2024, 2, 1): 110.0},
    {DateTime(2024, 2, 2): 90.0},
    {DateTime(2024, 2, 4): 115.5},
    {DateTime(2024, 2, 6): 120.0},
    {DateTime(2024, 2, 8): 130.0},
    {DateTime(2024, 2, 10): 95.0},
    {DateTime(2024, 2, 12): 90.5},
    {DateTime(2024, 2, 14): 105.0},
    {DateTime(2024, 2, 16): 125.0},
    {DateTime(2024, 2, 18): 130.0},
    {DateTime(2024, 2, 20): 100.0},
    {DateTime(2024, 2, 22): 125.5},
    {DateTime(2024, 2, 24): 120.5},
    {DateTime(2024, 2, 26): 90.5},
    {DateTime(2024, 2, 28): 115.0},

    {DateTime(2024, 3, 1): 130.0},
    {DateTime(2024, 3, 2): 110.5},
    {DateTime(2024, 3, 4): 95.0},
    {DateTime(2024, 3, 6): 105.5},
    {DateTime(2024, 3, 8): 120.0},
    {DateTime(2024, 3, 10): 90.0},
    {DateTime(2024, 3, 12): 125.0},
    {DateTime(2024, 3, 14): 130.0},
    {DateTime(2024, 3, 16): 100.0},
    {DateTime(2024, 3, 18): 125.5},
    {DateTime(2024, 3, 20): 120.5},
    {DateTime(2024, 3, 22): 115.0},
    {DateTime(2024, 3, 24): 110.0},
    {DateTime(2024, 3, 26): 95.5},
    {DateTime(2024, 3, 28): 100.5},

    {DateTime(2024, 4, 1): 90.5},
    {DateTime(2024, 4, 2): 130.0},
    {DateTime(2024, 4, 4): 105.0},
    {DateTime(2024, 4, 6): 95.0},
    {DateTime(2024, 4, 8): 115.5},
    {DateTime(2024, 4, 10): 110.0},
    {DateTime(2024, 4, 12): 125.0},
    {DateTime(2024, 4, 14): 120.0},
    {DateTime(2024, 4, 16): 130.0},
    {DateTime(2024, 4, 18): 100.0},
    {DateTime(2024, 4, 20): 115.5},
    {DateTime(2024, 4, 22): 120.0},
    {DateTime(2024, 4, 24): 125.5},
    {DateTime(2024, 4, 26): 130.0},
    {DateTime(2024, 4, 28): 105.0},

    {DateTime(2024, 5, 1): 120.5},
    {DateTime(2024, 5, 2): 130.0},
    {DateTime(2024, 5, 4): 110.5},
    {DateTime(2024, 5, 6): 95.0},
    {DateTime(2024, 5, 8): 100.0},
    {DateTime(2024, 5, 10): 115.0},
    {DateTime(2024, 5, 12): 90.5},
    {DateTime(2024, 5, 14): 125.0},
    {DateTime(2024, 5, 16): 120.5},
    {DateTime(2024, 5, 18): 130.0},
    {DateTime(2024, 5, 20): 100.5},
    {DateTime(2024, 5, 22): 115.5},
    {DateTime(2024, 5, 24): 105.5},
    {DateTime(2024, 5, 26): 125.5},
    {DateTime(2024, 5, 28): 130.5},

    {DateTime(2024, 6, 1): 130.0},
    {DateTime(2024, 6, 2): 95.0},
    {DateTime(2024, 6, 4): 120.0},
    {DateTime(2024, 6, 6): 110.5},
    {DateTime(2024, 6, 8): 125.5},
    {DateTime(2024, 6, 10): 100.5},
    {DateTime(2024, 6, 12): 115.0},
    {DateTime(2024, 6, 14): 90.0},
    {DateTime(2024, 6, 16): 130.0},
    {DateTime(2024, 6, 18): 125.5},
    {DateTime(2024, 6, 20): 110.0},
    {DateTime(2024, 6, 22): 115.5},
    {DateTime(2024, 6, 24): 100.5},
    {DateTime(2024, 6, 26): 95.5},
    {DateTime(2024, 6, 28): 130.0},

    {DateTime(2024, 7, 1): 120.5},
    {DateTime(2024, 7, 2): 110.5},
    {DateTime(2024, 7, 4): 130.0},
    {DateTime(2024, 7, 6): 105.5},
    {DateTime(2024, 7, 8): 115.0},
    {DateTime(2024, 7, 10): 125.5},
    {DateTime(2024, 7, 12): 130.0},
    {DateTime(2024, 7, 14): 100.0},
    {DateTime(2024, 7, 16): 95.5},
    {DateTime(2024, 7, 18): 130.5},
    {DateTime(2024, 7, 20): 110.0},
    {DateTime(2024, 7, 22): 115.5},
    {DateTime(2024, 7, 24): 120.0},
    {DateTime(2024, 7, 26): 105.0},
    {DateTime(2024, 7, 28): 130.5},
  ];

  final List<Map<DateTime, double>> data2 = [
    {DateTime(2024, 1, 1): 92.0},
    {DateTime(2024, 1, 2): 110.5},
    {DateTime(2024, 1, 4): 127.0},
    {DateTime(2024, 1, 6): 131.0},
    {DateTime(2024, 1, 8): 104.0},
    {DateTime(2024, 1, 10): 128.5},
    {DateTime(2024, 1, 12): 108.0},
    {DateTime(2024, 1, 14): 102.0},
    {DateTime(2024, 1, 16): 124.0},
    {DateTime(2024, 1, 18): 97.5},
    {DateTime(2024, 1, 20): 123.0},
    {DateTime(2024, 1, 22): 92.0},
    {DateTime(2024, 1, 24): 107.0},
    {DateTime(2024, 1, 26): 103.5},
    {DateTime(2024, 1, 30): 113.5},

    {DateTime(2024, 2, 1): 112.0},
    {DateTime(2024, 2, 2): 89.5},
    {DateTime(2024, 2, 4): 116.0},
    {DateTime(2024, 2, 6): 121.5},
    {DateTime(2024, 2, 8): 128.0},
    {DateTime(2024, 2, 10): 96.5},
    {DateTime(2024, 2, 12): 91.0},
    {DateTime(2024, 2, 14): 106.0},
    {DateTime(2024, 2, 16): 124.5},
    {DateTime(2024, 2, 18): 132.0},
    {DateTime(2024, 2, 20): 102.0},
    {DateTime(2024, 2, 22): 126.0},
    {DateTime(2024, 2, 24): 121.0},
    {DateTime(2024, 2, 26): 93.0},
    {DateTime(2024, 2, 28): 116.5},

    {DateTime(2024, 3, 1): 129.0},
    {DateTime(2024, 3, 2): 113.0},
    {DateTime(2024, 3, 4): 98.5},
    {DateTime(2024, 3, 6): 107.5},
    {DateTime(2024, 3, 8): 123.0},
    {DateTime(2024, 3, 10): 91.5},
    {DateTime(2024, 3, 12): 127.0},
    {DateTime(2024, 3, 14): 132.0},
    {DateTime(2024, 3, 16): 101.0},
    {DateTime(2024, 3, 18): 126.0},
    {DateTime(2024, 3, 20): 121.5},
    {DateTime(2024, 3, 22): 116.0},
    {DateTime(2024, 3, 24): 112.0},
    {DateTime(2024, 3, 26): 98.0},
    {DateTime(2024, 3, 28): 102.0},

    {DateTime(2024, 4, 1): 93.0},
    {DateTime(2024, 4, 2): 128.0},
    {DateTime(2024, 4, 4): 106.0},
    {DateTime(2024, 4, 6): 97.0},
    {DateTime(2024, 4, 8): 118.0},
    {DateTime(2024, 4, 10): 113.0},
    {DateTime(2024, 4, 12): 124.0},
    {DateTime(2024, 4, 14): 121.0},
    {DateTime(2024, 4, 16): 129.0},
    {DateTime(2024, 4, 18): 104.0},
    {DateTime(2024, 4, 20): 116.5},
    {DateTime(2024, 4, 22): 122.0},
    {DateTime(2024, 4, 24): 127.0},
    {DateTime(2024, 4, 26): 131.0},
    {DateTime(2024, 4, 28): 106.0},

    {DateTime(2024, 5, 1): 119.0},
    {DateTime(2024, 5, 2): 129.5},
    {DateTime(2024, 5, 4): 112.0},
    {DateTime(2024, 5, 6): 97.5},
    {DateTime(2024, 5, 8): 102.0},
    {DateTime(2024, 5, 10): 116.0},
    {DateTime(2024, 5, 12): 91.5},
    {DateTime(2024, 5, 14): 124.0},
    {DateTime(2024, 5, 16): 121.0},
    {DateTime(2024, 5, 18): 128.0},
    {DateTime(2024, 5, 20): 102.5},
    {DateTime(2024, 5, 22): 118.0},
    {DateTime(2024, 5, 24): 106.0},
    {DateTime(2024, 5, 26): 124.5},
    {DateTime(2024, 5, 28): 129.0},

    {DateTime(2024, 6, 1): 128.0},
    {DateTime(2024, 6, 2): 96.5},
    {DateTime(2024, 6, 4): 121.0},
    {DateTime(2024, 6, 6): 111.0},
    {DateTime(2024, 6, 8): 126.0},
    {DateTime(2024, 6, 10): 101.0},
    {DateTime(2024, 6, 12): 117.0},
    {DateTime(2024, 6, 14): 91.0},
    {DateTime(2024, 6, 16): 129.0},
    {DateTime(2024, 6, 18): 127.0},
    {DateTime(2024, 6, 20): 112.0},
    {DateTime(2024, 6, 22): 117.5},
    {DateTime(2024, 6, 24): 103.0},
    {DateTime(2024, 6, 26): 96.0},
    {DateTime(2024, 6, 28): 128.5},

    {DateTime(2024, 7, 1): 121.0},
    {DateTime(2024, 7, 2): 113.0},
    {DateTime(2024, 7, 4): 128.5},
    {DateTime(2024, 7, 6): 108.0},
    {DateTime(2024, 7, 8): 117.5},
    {DateTime(2024, 7, 10): 124.5},
    {DateTime(2024, 7, 12): 128.0},
    {DateTime(2024, 7, 14): 102.0},
    {DateTime(2024, 7, 16): 98.0},
    {DateTime(2024, 7, 18): 131.0},
    {DateTime(2024, 7, 20): 112.0},
    {DateTime(2024, 7, 22): 118.0},
    {DateTime(2024, 7, 24): 121.5},
    {DateTime(2024, 7, 26): 107.0},
    {DateTime(2024, 7, 28): 130.0},
  ];


  List<double> values = [20, 10, 12, 40, 10, 30, 80, 90, 40, 20, 34, 47];

  final _tabs = [
    const Tab(icon: Icon(CupertinoIcons.chart_pie),),
    const Tab(icon: Icon(CupertinoIcons.graph_square),),
  ];

  Color getColor(int index, int totalSections) {
    final hue = (index * 360 / totalSections) % 360;
    return HSVColor.fromAHSV(1.0, hue, 0.8, 0.9).toColor();
  }



  @override
  Widget build(BuildContext context) {

    List<FlSpot> spots = data.map((map) => map.entries
        .map((entry) => FlSpot(
      (entry.key.day + (entry.key.month - 1) * 31).toDouble(),
      entry.value,))
        .toList())
        .expand((x) => x)
        .toList();

    List<FlSpot> spots2 = data2.map((map) => map.entries
        .map((entry) => FlSpot(
      (entry.key.day + (entry.key.month - 1) * 31).toDouble(),
      entry.value,))
        .toList())
        .expand((x) => x)
        .toList();

    final double minY = spots.map((e) => e.y).reduce((a, b) => a < b ? a : b) - 2;
    final double maxY = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 2;
    final double minX = spots.map((e) => e.x).reduce((a, b) => a < b ? a : b);
    final double maxX = spots.map((e) => e.x).reduce((a, b) => a > b ? a : b);

    double interval = ((maxY - minY) / 7);

    List<double> firstDayOfMonthPositions = _calculateFirstDayPositions(data);

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
          const SizedBox(height: 10,),

          if(selected == 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomDropDown(title: 'Компании', important: false, dropDownList: const [], onSelected: (value){}, withoutTitle: true, withShadow: true,),
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

                if(selected == 0)
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  padding: const EdgeInsets.all(20),
                  child: PieChart(
                    PieChartData(
                      sections:List.generate(
                        values.length,
                            (index) {

                          return PieChartSectionData(
                            value: values[index],
                            color:  getColor(index, values.length),
                            radius: touchedIndex == index ? 80: 70,
                            titlePositionPercentageOffset: 1.3,
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

                if(selected == 1)
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 4,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20,top:10),
                        child: LineChart(
                          LineChartData(
                            minY: minY - interval - (interval / 2),
                            maxY: maxY + interval,
                            minX: minX,
                            maxX: maxX,
                            lineTouchData: LineTouchData(
                                getTouchedSpotIndicator:(barData, spotIndexes,){
                                  return spotIndexes.map((e) {
                                    return const TouchedSpotIndicatorData(
                                      FlLine(color: Colors.black, strokeWidth: 2.0, dashArray: [5,5]),
                                      FlDotData(show: true,),
                                    );
                                  }).toList();
                                },
                                touchSpotThreshold: 10,
                                touchTooltipData: LineTouchTooltipData(
                                  tooltipHorizontalOffset: 80,
                                  fitInsideVertically: true,
                                  fitInsideHorizontally: true,
                                  tooltipMargin: -20,
                                  getTooltipColor: (touchedSpot) => AppColors.mainBlue,
                                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                                    return touchedBarSpots.map((barSpot) {

                                      final DateTime  date = data.expand((map) => map.keys).firstWhere(
                                              (dateTime) => dateTime.day + (dateTime.month - 1) * 31 == barSpot.x.toInt()
                                      );

                                      return LineTooltipItem(
                                        '${barSpot.y} - ',
                                        const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: DateFormat('dd.MM.yyyy').format(date),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          )
                                        ]
                                      );
                                    }).toList();
                                  },
                                ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: spots,
                                isCurved: false,
                                barWidth: 1,
                                belowBarData: BarAreaData(show: false),
                                dotData: const FlDotData(show: false)
                              ),
                              LineChartBarData(
                                  spots: spots2,
                                  isCurved: false,
                                  barWidth: 1,
                                  color: Colors.red,
                                  belowBarData: BarAreaData(show: false),
                                  dotData: const FlDotData(show: false)
                              ),


                            ],
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  interval: 1,
                                  showTitles: true,
                                  reservedSize: 25,
                                  getTitlesWidget: (value, meta) {
                                    final int day = value.toInt() % 31;
                                    final int month = (value.toInt() / 31).floor() + 1;

                                    if(day == 15){
                                      return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          child: Text(_getMonthName(month),style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold),)
                                      );
                                    }else{
                                      return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          child: const SizedBox()
                                      );
                                    }

                                  },
                                ),
                              ),
                              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              leftTitles:  AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: interval,
                                      reservedSize: 30,
                                    getTitlesWidget: (value, meta) {
                                      return SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          child: Text('${value.round()}',style: const TextStyle(fontSize: 10),)
                                      );
                                    },
                                  )
                              ),
                              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

                            ),
                            borderData: FlBorderData(
                                show: true,
                              border: Border(
                                bottom: BorderSide(width: 1, color:  AppColors.borderGrey,),
                                left: BorderSide(width: 1, color:  AppColors.borderGrey,),
                              )
                            ),
                            gridData: FlGridData(
                              show: true,
                              verticalInterval: 1,
                              horizontalInterval: interval,
                              drawVerticalLine: true,
                              drawHorizontalLine: true,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: AppColors.borderGrey,
                                  strokeWidth: 1.0,
                                );
                              },
                              getDrawingVerticalLine: (value) {
                                if (firstDayOfMonthPositions.contains(value)) {
                                  return FlLine(
                                    color: AppColors.borderGrey,
                                    strokeWidth: 1,
                                  );
                                }
                                return const FlLine(
                                  strokeWidth: 0
                                );
                              },
                            ),
                          ),
                        ),
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

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      default:
        return '';
    }
  }

  double _calculateHorizontalInterval(int totalDays) {
    return (totalDays > 60) ? 15 : 7;
  }

  List<double> _calculateFirstDayPositions(List<Map<DateTime, double>> data) {
    Map<int, double> firstDayOfMonthMap = {};

    for (var entry in data) {
      entry.forEach((date, value) {
        int month = date.month;
        double position = (date.day + (month - 1) * 31).toDouble();
        if (!firstDayOfMonthMap.containsKey(month)) {
          firstDayOfMonthMap[month] = position;
        }
      });
    }

    return firstDayOfMonthMap.values.toList();
  }
}
