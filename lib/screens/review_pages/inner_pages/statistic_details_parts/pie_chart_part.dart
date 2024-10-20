
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:web_com/data/repository/contract_repository.dart';

import 'package:web_com/domain/client_contract_service.dart';
import 'package:web_com/screens/review_pages/inner_pages/statistic_details_parts/statistic_cubit/statistic_cubit.dart';
import 'package:web_com/widgets/shimmer_box.dart';

import '../../../../config/app_box_decoration.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_icons.dart';

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

  int touchedIndex = -1;

  StatisticCubit statisticCubit = StatisticCubit();

  @override
  void initState() {
    statisticCubit.getChartData(context, widget.navigationPageCubit, 'DONUT', saveService: true,needFullLoading: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: BlocProvider(
          create: (context) => statisticCubit,
        child: BlocBuilder(
          bloc: statisticCubit,
          builder: (context, state) {
            if(state is StatisticLoading){
              return const Padding(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ShimmerBox(width: double.infinity, height: 50),
                      SizedBox(height: 10),
                      ShimmerBox(width: double.infinity, height: 50),
                      SizedBox(height: 10),
                      ShimmerBox(width: double.infinity, height: 500),
                    ],
                  ),
                ),
              );
            }


            return RefreshIndicator(
              onRefresh: () async {
                statisticCubit.resetValues(context, widget.navigationPageCubit,'DONUT');
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
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
                              statisticCubit.serviceId = item.id;
                              statisticCubit.service = item;
                              statisticCubit.cabinetId = null;
                              statisticCubit.cabinet = null;
                              statisticCubit.getChartData(context, widget.navigationPageCubit, 'DONUT',saveCabinet: true);
                            }
                          }
                        },
                        withoutTitle: true,
                        withShadow: true,
                        selectedItem: statisticCubit.service?.name,
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
                        dropDownList: statisticCubit.clientContractServiceList.map((item) => item.name).toList(),
                        onSelected: (value) {
                          for(var item in statisticCubit.clientContractServiceList){
                            if(item.name == value){
                              statisticCubit.cabinetId = item.id;
                              statisticCubit.cabinet = item;
                              statisticCubit.getChartData(context, widget.navigationPageCubit, 'DONUT');
                            }
                          }
                        },
                        withoutTitle: true,
                        withShadow: true,
                        selectedItem: statisticCubit.cabinet?.name,
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
                                isSelected: statisticCubit.currentPosition == 0,
                                title: 'День',
                                onSelected: () {
                                  statisticCubit.changePosition(context, widget.navigationPageCubit, 0,'DONUT');
                                },
                              ),
                              PartColumn(
                                isSelected: statisticCubit.currentPosition == 1,
                                title: 'Неделя',
                                onSelected: () {
                                  statisticCubit.changePosition(context, widget.navigationPageCubit, 1,'DONUT');
                                },
                              ),
                              PartColumn(
                                isSelected: statisticCubit.currentPosition == 2,
                                title: 'Месяц',
                                onSelected: () {
                                  statisticCubit.changePosition(context, widget.navigationPageCubit, 2,'DONUT');
                                },
                              ),
                              IconButton(
                                  onPressed: (){
                                    statisticCubit.selectDateRange(context,widget.navigationPageCubit);
                                  },
                                  icon: SvgPicture.asset(AppIcons.calendar)
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          if(state is StatisticChartLoading)
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 30),
                                child: CircularProgressIndicator(color: AppColors.secondaryBlueDarker,)
                            ),

                          if(state is StatisticFetingSuccess)
                            if(state.metricReportGroupList.isEmpty)
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 30),
                                  child: Text('По указанным критериям нет данных',style: TextStyle(color: AppColors.mainGrey),)
                              ),

                          if(state is StatisticFetingSuccess)
                            if(state.chartValues.isNotEmpty)
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            padding: const EdgeInsets.all(20),
                            child: PieChart(
                              PieChartData(
                                sections: List.generate(
                                  state.chartValues.length, (index) {
                                    final value = state.chartValues.values.toList()[index];
                                    final displayValue = value == 0 ? 0.1 : value;

                                    return PieChartSectionData(
                                      value: displayValue,
                                      color: statisticCubit.getColor(index, state.chartValues.length),
                                      radius: touchedIndex == index ? 80 : 70,
                                      titlePositionPercentageOffset: 1.3,
                                      title: '',
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
                                            '${state.chartValues.keys.toList()[index]}: ${state.chartValues.values.toList()[index]}',
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
                          if(state is StatisticFetingSuccess)
                            if(state.metricReportGroupList.isNotEmpty)
                          DropDownMetrics(color: AppColors.secondaryBlueDarker,
                            onPressed: () {},
                            needBorder: true,
                            selected: false,
                            metricsValues: state.metricReportGroupList.first.metrics!.toJson(),
                            onMetricSelected: (value) {
                              statisticCubit.metricsChanged(state.metricReportGroupList, value);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


