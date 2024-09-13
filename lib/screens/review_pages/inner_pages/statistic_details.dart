import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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
  double currentScale = 1.0;
  late double lastMaxXValue;
  late double lastMinXValue;

  bool absorbing = false;
  double zoomLevel = 1.0;

  List<bool> listOfMetricValue = [false,false,false,false];

  List<int> colors = [0xff7F6BD8,0xffDB6ACB,0xff69B8DA,0xffD1D5DB];

  int selected = 0;
  int currentPosition = 0;
  int touchedIndex = -1;
  List<Map<DateTime, double>> data = [
    {DateTime(2024, 1, 1): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 2): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 3): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 4): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 5): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 6): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 7): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 8): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 9): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 10): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 11): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 12): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 13): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 1): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 2): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 3): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 4): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 5): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 6): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 7): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 8): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 9): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 10): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 1): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 2): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 3): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 4): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 5): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 6): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 7): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 8): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 9): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 10): (90 + Random().nextInt(41)).toDouble()},
  ];

  List<Map<DateTime, double>> data2 = [
    {DateTime(2024, 1, 1): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 2): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 3): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 4): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 5): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 6): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 7): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 8): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 9): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 10): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 11): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 12): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 1, 13): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 1): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 2): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 3): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 4): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 5): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 6): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 7): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 8): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 9): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 2, 10): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 1): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 2): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 3): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 4): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 5): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 6): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 7): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 8): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 9): (90 + Random().nextInt(41)).toDouble()},
    {DateTime(2024, 3, 10): (90 + Random().nextInt(41)).toDouble()},
  ];

  List<double> values = [20, 10, 12, 40, 10, 30, 80, 90, 40, 20, 34, 47];

  final _tabs = [
    const Tab(
      icon: Icon(CupertinoIcons.chart_pie),
    ),
    const Tab(
      icon: Icon(CupertinoIcons.graph_square),
    ),
  ];

  Color getColor(int index, int totalSections) {
    final hue = (index * 360 / totalSections) % 360;
    return HSVColor.fromAHSV(1.0, hue, 0.8, 0.9).toColor();
  }

  List<FlSpot> spots1 = [];
  List<FlSpot> spots2 = [];

  @override
  void initState() {
    readyAllData();
    super.initState();
  }

  double minY = 0;
  double maxY = 0;
  double minX = 0;
  double maxX = 0;
  double baseMaxX = 0;
  double interval = 0;

  void readyAllData() {
    setState(() {
      spots1 = getSpots(data);
      spots2 = getSpots(data2);
    });

    getCalculation();
  }

  void getCalculation() {
    double minY1 = spots1.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    double maxY1 = spots1.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    double minX1 = spots1.map((e) => e.x).reduce((a, b) => a < b ? a : b);
    double maxX1 = spots1.map((e) => e.x).reduce((a, b) => a > b ? a : b);

    double minY2 = spots2.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    double maxY2 = spots2.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    double minX2 = spots2.map((e) => e.x).reduce((a, b) => a < b ? a : b);
    double maxX2 = spots2.map((e) => e.x).reduce((a, b) => a > b ? a : b);

    maxX = maxX1 > maxX2 ? maxX1 : maxX2;
    maxY = maxY1 > maxY2 ? maxY1 : maxY2;
    minY = minY1 < minY2 ? minY1 : minY2;
    minX = minX1 < minX2 ? minX1 : minX2;

    baseMaxX = maxX;
    interval = ((maxY - minY) / 4);

    setState(() {});
  }

  List<FlSpot> getSpots(List<Map<DateTime, double>> data) {
    return List.generate(data.length, (index) {
      var entry = data[index];
      DateTime key = entry.keys.first;
      double value = entry.values.first;
      return FlSpot(index.toDouble(), value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 15,
            )),
        title: const Align(
            alignment: Alignment.center,
            child: Text('Google Ads',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CommonTabBar(
                  tabs: _tabs,
                  onPressed: (value) {
                    setState(() {
                      selected = value;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomDropDown(
                title: 'Кабинеты',
                important: false,
                dropDownList: const [],
                onSelected: (value) {},
                withoutTitle: true,
                withShadow: true,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (selected == 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomDropDown(
                  title: 'Компании',
                  important: false,
                  dropDownList: const [],
                  onSelected: (value) {},
                  withoutTitle: true,
                  withShadow: true,
                ),
              ),
            Container(
              margin: const EdgeInsets.all(20),
              decoration: AppBoxDecoration.boxWithShadow,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                  const SizedBox(
                    height: 20,
                  ),
                  if (selected == 0)
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      padding: const EdgeInsets.all(20),
                      child: PieChart(
                        PieChartData(
                          sections: List.generate(
                            values.length,
                            (index) {
                              return PieChartSectionData(
                                value: values[index],
                                color: getColor(index, values.length),
                                radius: touchedIndex == index ? 80 : 70,
                                titlePositionPercentageOffset: 1.3,
                                title: '${values[index]}',
                                badgeWidget: touchedIndex == index
                                    ? Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: AppColors.secondaryBlueDarker,
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          '${values[index]}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ))
                                    : null,
                              );
                            },
                          ),
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  if (selected == 1)
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: GestureDetector(
                        // onDoubleTap: () {
                        //   getCalculation();
                        // },
                        // onHorizontalDragStart: (details) {
                        //   lastMinXValue = minX;
                        //   lastMaxXValue = maxX;
                        // },
                        // onHorizontalDragUpdate: (details) {
                        //   var horizontalDistance = details.primaryDelta ?? 0;
                        //   if (horizontalDistance == 0) return;
                        //   var lastMinMaxDistance =
                        //       max(lastMaxXValue - lastMinXValue, 0.0);
                        //
                        //   setState(() {
                        //     minX -=
                        //         lastMinMaxDistance * 0.005 * horizontalDistance;
                        //     maxX -=
                        //         lastMinMaxDistance * 0.005 * horizontalDistance;
                        //
                        //     if (minX < 0) {
                        //       minX = 0;
                        //       maxX = lastMinMaxDistance;
                        //     }
                        //     if (maxX > maxX) {
                        //       maxX = maxX;
                        //       minX = maxX - lastMinMaxDistance;
                        //     }
                        //   });
                        // },
                        // onScaleStart: (details) {
                        //   setState(() {
                        //     absorbing = true;
                        //   });
                        //   lastMinXValue = minX;
                        //   lastMaxXValue = maxX;
                        // },
                        // onScaleEnd: (details) {
                        //   setState(() {
                        //     absorbing = false;
                        //   });
                        // },
                        // onScaleUpdate: (details) {
                        //   var horizontalScale = details.horizontalScale;
                        //   if (horizontalScale == 0) return;
                        //
                        //   var lastMinMaxDistance =
                        //       max(lastMaxXValue - lastMinXValue, 0);
                        //   var newMinMaxDistance =
                        //       max(lastMinMaxDistance / horizontalScale, 10);
                        //   var distanceDifference =
                        //       newMinMaxDistance - lastMinMaxDistance;
                        //
                        //   setState(() {
                        //     zoomLevel = horizontalScale; // Update zoom level
                        //     final newMinX = max(
                        //       lastMinXValue - distanceDifference,
                        //       0.0,
                        //     );
                        //     final newMaxX = min(
                        //       lastMaxXValue + distanceDifference,
                        //       maxX,
                        //     );
                        //
                        //     if (newMaxX - newMinX > 2) {
                        //       minX = newMinX;
                        //       maxX = newMaxX;
                        //     }
                        //   });
                        // },
                        child: ClipRRect(
                          child: LineChart(
                            LineChartData(
                              minY: minY != 0 ? minY - interval : null,
                              maxY: maxY != 0 ? maxY + (interval / 2) : null,
                              minX: minX != 0 ? minX : null,
                              maxX: maxX != 0 ? maxX : null,
                              lineTouchData: LineTouchData(
                                // enabled: absorbing,
                                getTouchedSpotIndicator: (
                                  barData,
                                  spotIndexes,
                                ) {
                                  return spotIndexes.map((e) {
                                    return TouchedSpotIndicatorData(
                                      FlLine(
                                          color: AppColors.mainGrey,
                                          strokeWidth: 2.0,
                                          dashArray: [5, 5]),
                                      const FlDotData(
                                        show: false,
                                      ),
                                    );
                                  }).toList();
                                },
                                touchSpotThreshold: 10,
                                touchTooltipData: LineTouchTooltipData(
                                  tooltipHorizontalOffset: 45,
                                  fitInsideVertically: true,
                                  tooltipPadding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  fitInsideHorizontally: true,
                                  tooltipMargin: -20,
                                  getTooltipColor: (touchedSpot) =>
                                      AppColors.mainBlue,
                                  getTooltipItems:
                                      (List<LineBarSpot> touchedBarSpots) {
                                    return touchedBarSpots.map((barSpot) {
                                      return LineTooltipItem(
                                        '${barSpot.y}',
                                        const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: spots1,
                                  isCurved: true,
                                  barWidth: 1,
                                  color: Color(colors[0]),
                                  dotData: const FlDotData(show: false),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        const Color(0xff9A83FF).withOpacity(0.3),
                                        Colors.white
                                      ]
                                          .map((color) => color.withOpacity(0.2))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                LineChartBarData(
                                    spots: spots2,
                                    isCurved: true,
                                    barWidth: 1,
                                    color: Color(colors[1]),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          const Color(0xff9A83FF).withOpacity(0.3),
                                          Colors.white
                                        ]
                                            .map((color) => color.withOpacity(0.2))
                                            .toList(),
                                      ),
                                    ),
                                    dotData: const FlDotData(show: false)),
                              ],
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    interval: 1,
                                    showTitles: true,
                                    reservedSize: 25,
                                    getTitlesWidget: (value, meta) {
                                      if (value.toInt() >= data.length - 1 ||
                                          value < 0) {
                                        return const SizedBox();
                                      }

                                      DateTime date =
                                          data[value.toInt()].keys.first;

                                      if (zoomLevel > 1.5) {
                                        // Show days
                                        return Text(
                                          '${date.month}.${date.day}',
                                          style: TextStyle(
                                            color: AppColors.secondaryGreyDarker,
                                            fontSize: 10,
                                          ),
                                        );
                                      } else {
                                        // Show months
                                        if (date.day == 1) {
                                          return Container(
                                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
                                            child: Text(
                                              AppTexts.months[date.month - 1],
                                              style: TextStyle(
                                                color: AppColors.secondaryGreyDarker,
                                                fontSize: 10,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      }
                                    },
                                  ),
                                ),
                                rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: interval != 0 ? interval : null,
                                  reservedSize: 30,
                                  getTitlesWidget: (value, meta) {
                                    return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Text(
                                          '${value.round()}',
                                          style: const TextStyle(fontSize: 10),
                                        ));
                                  },
                                )),
                                topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),
                              borderData: FlBorderData(
                                  show: true,
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: AppColors.secondaryBlueDarker,
                                    ),
                                    // left: BorderSide(width: 1, color:  AppColors.secondaryBlueDarker,),
                                    // top: BorderSide(width: 1, color:  AppColors.secondaryBlueDarker,),
                                    // right: BorderSide(width: 1, color:  AppColors.secondaryBlueDarker,),
                                  )),
                              clipData: const FlClipData.all(),
                              gridData: FlGridData(
                                show: true,
                                verticalInterval: 1,
                                horizontalInterval:
                                    interval != 0 ? interval : null,
                                drawVerticalLine: true,
                                drawHorizontalLine: true,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: AppColors.borderGrey,
                                    strokeWidth: 1.0,
                                  );
                                },
                                getDrawingVerticalLine: (value) {
                                  if (value.toInt() >= data.length - 1 ||
                                      value < 0) {
                                    return const FlLine(strokeWidth: 0);
                                  }

                                  DateTime date = data[value.toInt()].keys.first;
                                  if (date.day == 1) {
                                    return FlLine(
                                      color: AppColors.borderGrey,
                                      strokeWidth: 1.0,
                                    );
                                  } else {
                                    return const FlLine(strokeWidth: 0);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),


                  SfCartesianChart(

                    trackballBehavior: TrackballBehavior(
                      enable: true,
                      activationMode: ActivationMode.singleTap,  // Activate on tap
                      tooltipSettings: const InteractiveTooltip(
                        enable: true,  // Enable tooltip along with trackball
                        format: 'point.x : point.y',  // Display date and value
                      ),
                    ),

                    // Enable zoom and pan behavior
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true,
                      enablePinching: true,
                      zoomMode: ZoomMode.xy,
                    ),

                    primaryXAxis: const DateTimeAxis(),
                    primaryYAxis: const NumericAxis(),

                    // Define multiple series
                    series: <CartesianSeries>[


                      SplineAreaSeries<ChartData, DateTime>(
                        dataSource: dataDate,
                        xValueMapper: (ChartData data, _) => data.date,
                        yValueMapper: (ChartData data, _) => data.value,
                        name: 'Series 1',
                        gradient:  LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xff9A83FF).withOpacity(0.3),
                            Colors.white
                          ].map((color) => color.withOpacity(0.2)).toList(),
                        ),
                        borderColor: Color(colors[0]),
                        borderWidth: 1,
                      ),

                      SplineAreaSeries<ChartData, DateTime>(
                        dataSource: dataDate2,
                        xValueMapper: (ChartData data, _) => data.date,
                        yValueMapper: (ChartData data, _) => data.value,
                        name: 'Series 2',
                        color:Color(colors[1]),
                        gradient:  LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xff9A83FF).withOpacity(0.3),
                            Colors.white
                          ].map((color) => color.withOpacity(0.2)).toList(),
                        ),
                        borderColor: Color(colors[1]),
                        borderWidth: 1,
                      ),


                      SplineAreaSeries<ChartData, DateTime>(
                        dataSource: dataDate3,
                        xValueMapper: (ChartData data, _) => data.date,
                        yValueMapper: (ChartData data, _) => data.value,
                        name: 'Series 3',
                        gradient:  LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xff9A83FF).withOpacity(0.3),
                            Colors.white
                          ].map((color) => color.withOpacity(0.2)).toList(),
                        ),
                        borderColor: Color(colors[2]),
                        borderWidth: 1,

                      ),
                    ],
                  ),

                  if (selected == 0)
                  DropDownMetrics(color: AppColors.secondaryBlueDarker, onPressed: () {  }, needBorder: true, selected: false,),
                  if (selected == 1)

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context,index){
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                          child: DropDownMetrics(color: Color(colors[index]),selected: listOfMetricValue[index], onPressed: () {
                            setState(() {
                              listOfMetricValue[index] = !listOfMetricValue[index];
                            });
                          },)
                      );
                    }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class DropDownMetrics extends StatelessWidget {
  const DropDownMetrics({super.key,required this.selected, required this.color, required this.onPressed, this.needBorder = false});

  final bool selected;
  final Color color;
  final bool needBorder;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: selected ? color : needBorder ? color : AppColors.borderGrey,width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(12))
          ),
          child: selected ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(width: 40,),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Клики',
                        style: TextStyle(color: AppColors.mainGrey),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.mainGrey,
                      ),
                    ],
                  ),
                  Text(
                    '54 558',
                    style: TextStyle(
                        fontSize: 20,
                        color: !needBorder ? Colors.black: AppColors.secondaryBlueDarker),
                  )
                ],
              ),

              CustomPaint(
                painter: TrianglePainter( selected ? color : AppColors.borderGrey),
                child: const SizedBox(
                  width: 40,
                  height: 40,
                    child: Align(
                      alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.check_rounded, color: Colors.white,size: 17,),
                        )
                    )

                ),
              ),
            ],
          ): Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Клики',
                    style: TextStyle(color: AppColors.mainGrey),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.mainGrey,
                  ),
                ],
              ),
              Text(
                '54 558',
                style: TextStyle(
                    fontSize: 20,
                    color: !needBorder ? Colors.black: AppColors.secondaryBlueDarker),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class TrianglePainter extends CustomPainter {

  final Color color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


class ChartData {
  final DateTime date;
  final double value;

  ChartData(this.date, this.value);
}

List<ChartData> dataDate = [
  ChartData(DateTime(2024, 1, 1), 35),
  ChartData(DateTime(2024, 2, 1), 28),
  ChartData(DateTime(2024, 3, 1), 34),
  ChartData(DateTime(2024, 4, 1), 32),
  ChartData(DateTime(2024, 5, 1), 40),
];

List<ChartData> dataDate2 = [
  ChartData(DateTime(2024, 1, 1), 55),
  ChartData(DateTime(2024, 2, 1), 28),
  ChartData(DateTime(2024, 3, 1), 36),
  ChartData(DateTime(2024, 4, 1), 67),
  ChartData(DateTime(2024, 5, 1), 43),
];

List<ChartData> dataDate3 = [
  ChartData(DateTime(2024, 1, 1), 5500),
  ChartData(DateTime(2024, 2, 1), 2800),
  ChartData(DateTime(2024, 3, 1), 3600),
  ChartData(DateTime(2024, 4, 1), 6700),
  ChartData(DateTime(2024, 5, 1), 4300),
];