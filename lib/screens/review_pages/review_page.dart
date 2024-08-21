import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_com/widgets/months_builder.dart';
import 'package:web_com/widgets/search_app_bar.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_texts.dart';
import '../../widgets/speed_action_button.dart';
import '../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});



  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {

  TextEditingController controller =TextEditingController();

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
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
        appBar: SearchAppBar(onMenuButtonPressed: () {
          navigationPageCubit.openDrawer();
        }, isRed: true, searchController: controller,),
        body: Column(
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
                    return Container(
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
                    );
                  }),
            )
          ],
        ),

        floatingActionButton: const SpeedActionButton(),

        bottomNavigationBar:  NavigationBar(
          indicatorColor: AppColors.mainBlue,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(seconds: 1),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: _navBarItems,

        ),
    );
  }
}

List<NavigationDestination> _navBarItems = [
  NavigationDestination(
    icon: const Icon(Icons.home_outlined),
    selectedIcon: const Icon(Icons.home_rounded,color: Colors.white,),
    label: AppTexts.review,
  ),
  NavigationDestination(
    icon: const Icon(Icons.bookmark_border_outlined),
    selectedIcon: const Icon(Icons.bookmark_rounded,color: Colors.white,),
    label: AppTexts.review,
  ),
  NavigationDestination(
    icon: const Icon(Icons.shopping_bag_outlined),
    selectedIcon: const Icon(Icons.shopping_bag,color: Colors.white,),
    label: AppTexts.review,
  ),
];