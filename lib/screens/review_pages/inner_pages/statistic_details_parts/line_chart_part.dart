import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../config/app_box_decoration.dart';
import '../../../../config/app_icons.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/drop_down_metrics.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import '../review_profile.dart';


class LineChartPart extends StatefulWidget {
  const LineChartPart({super.key, required this.navigationPageCubit});

  final NavigationPageCubit navigationPageCubit;

  @override
  State<LineChartPart> createState() => _LineChartPartState();
}

class _LineChartPartState extends State<LineChartPart> {

  int currentPosition = 0;

  List<bool> listOfMetricValue = [true,true,true,true];
  List<String?> titles = [];
  List<int> colors = [0xff7F6BD8,0xffDB6ACB,0xff69B8DA,0xffD1D5DB];



  @override
  void initState() {
    for(int i=0; i<listOfMetricValue.length; i++){
      setLineAxis(i);
    }
    super.initState();
  }

  void setLineAxis(int index){
    setState(() {
      String? assignedYAxis;
      switch(index){
        case 0:
          assignedYAxis = assignYAxis(dataDate);
          break;
        case 1:
          assignedYAxis = assignYAxis(dataDate2);
          break;
        case 2:
          assignedYAxis = assignYAxis(dataDate3);
          break;
        case 3:
          assignedYAxis = assignYAxis(dataDate4);
          break;
      }

      if(listOfMetricValue[index]){
        yAxisUsage.forEach((axis, _) {
          if(assignedYAxis == axis && yAxisUsage[axis]!= null){
            yAxisUsage[axis] = yAxisUsage[axis]! + 1;
          }
        });
      }else{
        yAxisUsage.forEach((axis, _) {
          if(assignedYAxis == axis && yAxisUsage[axis]!= null){
            yAxisUsage[axis] = yAxisUsage[axis]! -1;
          }
        });
      }
    });
  }

  Map<String, int> yAxisUsage = {
    'FirstYAxis': 0,
    'SecondaryYAxis': 0,
    'ThirdYAxis': 0,
    'FourthYAxis': 0,
  };

  String? assignYAxis(List<ChartData> data) {
    double averageValue = data.map((d) => d.value).reduce((a, b) => a + b) / data.length;

    if (averageValue <= 1000) {
      return 'FirstYAxis';
    } else if (averageValue <= 10000) {
      return 'SecondaryYAxis';
    } else if (averageValue <= 100000) {
      return 'ThirdYAxis';
    } else {
      return 'FourthYAxis';
    }
  }

  bool shouldShowAxis(String? name) {
    for(int i=0; i<titles.length; i++){
      if(titles[i] == name){
        if(listOfMetricValue[i]){
          continue;
        }else{
          return false;
        }
      }
    }

    if(titles.isEmpty){
      return false;
    }

    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomDropDown(
            title: 'Сервисы',
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
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: SfCartesianChart(
                  trackballBehavior: TrackballBehavior(
                    enable: true,
                    activationMode: ActivationMode.singleTap,
                    tooltipSettings: const InteractiveTooltip(
                      enable: true,
                      format: 'point.x : point.y',
                    ),
                  ),

                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                    enablePinching: true,
                    zoomMode: ZoomMode.xy,
                  ),

                  primaryXAxis: const DateTimeAxis(),

                  primaryYAxis: NumericAxis(
                    name: 'FirstYAxis',
                    isVisible: yAxisUsage['FirstYAxis']!= null && yAxisUsage['FirstYAxis']! > 0,
                    numberFormat: NumberFormat.compact(),
                  ),
                  axes: <NumericAxis>[
                    NumericAxis(
                      name: 'SecondaryYAxis',
                      isVisible: yAxisUsage['SecondaryYAxis']!= null && yAxisUsage['SecondaryYAxis']! > 0,
                      numberFormat: NumberFormat.compact(),
                    ),
                    NumericAxis(
                      name: 'ThirdYAxis',
                      opposedPosition: true,
                      isVisible: yAxisUsage['ThirdYAxis']!= null && yAxisUsage['ThirdYAxis']! > 0 ,
                      numberFormat: NumberFormat.compact(),
                    ),
                    NumericAxis(
                      name: 'FourthYAxis',
                      opposedPosition: true,
                      isVisible: yAxisUsage['FourthYAxis']!= null && yAxisUsage['FourthYAxis']! > 0,
                      numberFormat: NumberFormat.compact(),
                    ),
                  ],

                  series: <CartesianSeries>[
                    if (listOfMetricValue[0])
                      SplineAreaSeries<ChartData, DateTime>(
                        dataSource: dataDate,
                        xValueMapper: (ChartData data, _) => data.date,
                        yValueMapper: (ChartData data, _) => data.value,
                        yAxisName: assignYAxis(dataDate),
                        name: 'Series 1',
                        gradient: LinearGradient(
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

                    if (listOfMetricValue[1])
                      SplineAreaSeries<ChartData, DateTime>(
                        dataSource: dataDate2,
                        xValueMapper: (ChartData data, _) => data.date,
                        yValueMapper: (ChartData data, _) => data.value,
                        yAxisName: assignYAxis(dataDate2),
                        name: 'Series 2',
                        color: Color(colors[1]),
                        gradient: LinearGradient(
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

                    if (listOfMetricValue[2])
                      SplineAreaSeries<ChartData, DateTime>(
                        dataSource: dataDate3,
                        xValueMapper: (ChartData data, _) => data.date,
                        yValueMapper: (ChartData data, _) => data.value,
                        yAxisName: assignYAxis(dataDate3),
                        name: 'Series 3',
                        gradient: LinearGradient(
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

                    if (listOfMetricValue[3])
                      SplineAreaSeries<ChartData, DateTime>(
                        dataSource: dataDate4,
                        xValueMapper: (ChartData data, _) => data.date,
                        yValueMapper: (ChartData data, _) => data.value,
                        yAxisName: assignYAxis(dataDate4),
                        name: 'Series 4',
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xff9A83FF).withOpacity(0.3),
                            Colors.white
                          ].map((color) => color.withOpacity(0.2)).toList(),
                        ),
                        borderColor: Color(colors[3]),
                        borderWidth: 1,
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
                            setLineAxis(index);
                          });

                        },)
                    );
                  }
              )
            ],
          ),
        )
      ],
    );
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
  ChartData(DateTime(2024, 1, 1), 6500),
  ChartData(DateTime(2024, 2, 1), 1800),
  ChartData(DateTime(2024, 3, 1), 1600),
  ChartData(DateTime(2024, 4, 1), 8700),
  ChartData(DateTime(2024, 5, 1), 8300),
];


List<ChartData> dataDate4 = [
  ChartData(DateTime(2024, 1, 1), 15500),
  ChartData(DateTime(2024, 2, 1), 19800),
  ChartData(DateTime(2024, 3, 1), 15600),
  ChartData(DateTime(2024, 4, 1), 18700),
  ChartData(DateTime(2024, 5, 1), 18300),
];