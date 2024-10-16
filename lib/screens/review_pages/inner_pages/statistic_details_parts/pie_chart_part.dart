
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:web_com/data/repository/contract_repository.dart';
import 'package:web_com/data/repository/service_repository.dart';
import 'package:web_com/domain/client_contract_service.dart';
import 'package:web_com/screens/review_pages/inner_pages/statistic_details_parts/statistic_cubit/statistic_cubit.dart';
import 'package:web_com/widgets/shimmer_box.dart';

import '../../../../config/app_box_decoration.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_icons.dart';
import '../../../../domain/service.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/drop_down_metrics.dart';
import '../../../../widgets/lazy_drop_down.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import '../review_profile.dart';

class PieChartPart extends StatefulWidget {
  const PieChartPart({super.key, required this.navigationPageCubit});

  final NavigationPageCubit navigationPageCubit;

  @override
  State<PieChartPart> createState() => _PieChartPartState();
}

class _PieChartPartState extends State<PieChartPart> {

  List<double> values = [20, 10, 12, 40, 10, 30, 80, 90, 40, 20, 34, 47];
  int currentPosition = 1;
  int touchedIndex = -1;

  int? cabinetId;
  int? serviceId;

  Color getColor(int index, int totalSections) {
    final hue = (index * 360 / totalSections) % 360;
    return HSVColor.fromAHSV(1.0, hue, 0.8, 0.9).toColor();
  }

  String getPeriod() {
    switch(currentPosition){
      case 0:
        return 'DAY';
      case 1:
        return 'WEEK';
      case 2:
        return 'MONTH';
      default:
        return '';
    }
  }

  StatisticCubit statisticCubit = StatisticCubit();

  @override
  void initState() {
    statisticCubit.getChartData(context, widget.navigationPageCubit, 'DONUT', getPeriod() , saveService: true);
    super.initState();
  }

  DateTimeRange? selectedDateRange;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: selectedDateRange,
    );
    if (picked != null && picked != selectedDateRange) {
      selectedDateRange = picked;
      makeChartParamChangeRequest();
      print(selectedDateRange);
    }
  }

  void makeChartParamChangeRequest(){
    statisticCubit.getChartData(context, widget.navigationPageCubit,
        'DONUT',
        getPeriod(),
        startDate: selectedDateRange != null ?  DateFormat('yyyy-MM-dd').format(selectedDateRange!.start): null,
        endDate: selectedDateRange != null ?  DateFormat('yyyy-MM-dd').format(selectedDateRange!.end): null,
        serviceId: serviceId,
        cabinetId: cabinetId
    );
  }


  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return BlocProvider(
        create: (context) => statisticCubit,
      child: BlocBuilder(
        bloc: statisticCubit,
        builder: (context, state) {
          if(state is StatisticLoading){
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ShimmerBox(width: double.infinity, height: 50),
                  SizedBox(height: 10),
                  ShimmerBox(width: double.infinity, height: 50),
                  SizedBox(height: 10),
                  ShimmerBox(width: double.infinity, height: 500),
                ],
              ),
            );
          }


          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomDropDown(
                  title: 'Сервисы',
                  important: false,
                  dropDownList: statisticCubit.serviceList.map((item) => item.name).toList(),
                  onSelected: (value) {
                    for(var item in statisticCubit.serviceList){
                      if(item.name == value){
                        serviceId = item.id;
                        makeChartParamChangeRequest();
                      }
                    }
                  },
                  withoutTitle: true,
                  withShadow: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: LazyDropDown(
                  navigationPageCubit: navigationPageCubit,
                  selected: (ClientContractService? value) {
                    if(value!= null){
                      cabinetId = value.id;
                      makeChartParamChangeRequest();
                    }
                  },
                  currentValue: null,
                  title: 'Кабинеты',
                  important: false,
                  getData: (int page, int size, String query) => ContractRepository.getContractService(context,query, page, size),
                  fromJson: (json) => ClientContractService.fromJson(json),
                  fieldName: 'name',
                  toJson: (service) => service!.toJson(),
                  noBorder: true,
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
                            makeChartParamChangeRequest();
                          },
                        ),
                        PartColumn(
                          isSelected: currentPosition == 1,
                          title: 'Неделя',
                          onSelected: () {
                            setState(() {
                              currentPosition = 1;
                            });
                            makeChartParamChangeRequest();
                          },
                        ),
                        PartColumn(
                          isSelected: currentPosition == 2,
                          title: 'Месяц',
                          onSelected: () {
                            setState(() {
                              currentPosition = 2;
                            });
                            makeChartParamChangeRequest();
                          },
                        ),
                        IconButton(
                            onPressed: (){
                              _selectDateRange(context);
                            },
                            icon: SvgPicture.asset(AppIcons.calendar)
                        )
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
        },
      ),
    );
  }
}


