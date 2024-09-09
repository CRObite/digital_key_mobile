import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_icons.dart';
import '../../../config/app_texts.dart';
import '../../../widgets/months_builder.dart';

class ReviewStatistics extends StatefulWidget {
  const ReviewStatistics({super.key});

  @override
  State<ReviewStatistics> createState() => _ReviewStatisticsState();
}

class _ReviewStatisticsState extends State<ReviewStatistics> {

  int selectedMonth = 0;
  late int currentMonthIndex;

  List<int> grafOneData = [0, 5, 18, 1, 15, 11, 14, 3, 18, 11, 18, 1,];
  List<int> grafTwoData = [0, 2, 15, 19, 7, 2, 12, 13, 11, 17, 5, 5, ];

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    currentMonthIndex = now.month - 1;
    selectedMonth = currentMonthIndex;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppTexts.advertisingData,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(AppIcons.calendar)
            ],
          ),
        ),
        MonthsBuilder(
            currentMonthIndex: currentMonthIndex,
            onPressed: (value) {
              setState(() {
                selectedMonth = value;
              });
            },
            selectedMonth: selectedMonth),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 10,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    context.push('/statisticDetails');
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: index != 9 ? 30 : 60),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                'assets/images/vk.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'VK Ads',
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: '12 546',
                                          style:
                                          TextStyle(color: Colors.black)),
                                      TextSpan(
                                          text: ',56 \$',
                                          style: TextStyle(
                                              color: Colors.grey.shade400)),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: SizedBox(
                              height: 35,
                              child: LineChart(
                                LineChartData(
                                  gridData: const FlGridData(show: false),
                                  titlesData: const FlTitlesData(show: false),
                                  borderData: FlBorderData(show: false),
                                  minX: 0,
                                  minY: 0,
                                  lineTouchData: const LineTouchData(enabled: false),
                                  lineBarsData: [
                                    LineChartBarData(
                                      color: AppColors.blueForMetricColor,
                                      spots: grafOneData.asMap().entries.map((e) {
                                        return FlSpot(e.key.toDouble(), e.value.toDouble());
                                      }).toList(),
                                      isCurved: false,
                                      barWidth: 1.5,
                                      isStrokeCapRound: false,
                                      dotData: const FlDotData(show: false),
                                      belowBarData: BarAreaData(show: false),
                                    ),
                                    LineChartBarData(
                                      color: AppColors.blueForMetricSecondColor,
                                      spots: grafTwoData.asMap().entries.map((e) {
                                        return FlSpot(e.key.toDouble(), e.value.toDouble());
                                      }).toList(),
                                      isCurved: false,
                                      barWidth: 1.5,
                                      isStrokeCapRound: false,
                                      dotData: const FlDotData(show: false),
                                      belowBarData: BarAreaData(show: false),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '54 558',
                              style: TextStyle(
                                  color: AppColors.blueForMetricColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '12 435',
                              style: TextStyle(
                                  color: AppColors.blueForMetricSecondColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
