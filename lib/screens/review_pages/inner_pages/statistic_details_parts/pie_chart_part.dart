
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/app_box_decoration.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_icons.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/drop_down_metrics.dart';
import '../review_profile.dart';

class PieChartPart extends StatefulWidget {
  const PieChartPart({super.key});

  @override
  State<PieChartPart> createState() => _PieChartPartState();
}

class _PieChartPartState extends State<PieChartPart> {

  List<double> values = [20, 10, 12, 40, 10, 30, 80, 90, 40, 20, 34, 47];
  int currentPosition = 0;
  int touchedIndex = -1;

  Color getColor(int index, int totalSections) {
    final hue = (index * 360 / totalSections) % 360;
    return HSVColor.fromAHSV(1.0, hue, 0.8, 0.9).toColor();
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

              const SizedBox(
                height: 20,
              ),

              DropDownMetrics(color: AppColors.secondaryBlueDarker, onPressed: () {  }, needBorder: true, selected: false,),
            ],
          ),
        )
      ],
    );
  }
}


