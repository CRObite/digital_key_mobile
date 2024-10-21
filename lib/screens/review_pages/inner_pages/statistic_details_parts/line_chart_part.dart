import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:web_com/screens/review_pages/inner_pages/statistic_details_parts/statistic_cubit/statistic_cubit.dart';

import '../../../../config/app_box_decoration.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_icons.dart';
import '../../../../data/repository/contract_repository.dart';
import '../../../../domain/client_contract_service.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/drop_down_metrics.dart';
import '../../../../widgets/lazy_drop_down.dart';
import '../../../../widgets/shimmer_box.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import '../review_profile.dart';


class LineChartPart extends StatefulWidget {
  const LineChartPart({super.key, required this.navigationPageCubit});

  final NavigationPageCubit navigationPageCubit;

  @override
  State<LineChartPart> createState() => _LineChartPartState();
}

class _LineChartPartState extends State<LineChartPart> {



  StatisticCubit statisticCubit = StatisticCubit();


  @override
  void initState() {
    statisticCubit.getChartData(context, widget.navigationPageCubit, 'LINE', saveService: true, needFullLoading: true);
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
                statisticCubit.resetValues(context, widget.navigationPageCubit,'LINE');
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
                              statisticCubit.getChartData(context, widget.navigationPageCubit, 'LINE',saveCabinet: true);
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
                      child: LazyDropDown(
                        navigationPageCubit: widget.navigationPageCubit,
                        selected: (ClientContractService? value) {
                          if(value!= null){
                            statisticCubit.cabinetId = value.id;
                            statisticCubit.cabinet = value;
                            statisticCubit.getChartData(context, widget.navigationPageCubit, 'LINE');
                          }
                        },
                        currentValue: statisticCubit.cabinet,
                        title: 'Кабинеты',
                        important: false,
                        getData: (int page, int size, String query) => ContractRepository.getContractService(context,query, page, size,clientId: statisticCubit.clientId,serviceId: statisticCubit.serviceId),
                        fromJson: (json) => ClientContractService.fromJson(json),
                        fieldName: 'name',
                        toJson: (service) => service.toJson(),
                        noBorder: true,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomDropDown(
                        title: 'Компаний',
                        important: false,
                        dropDownList: const [],
                        onSelected: (value) {
                          // for(var item in statisticCubit.serviceList){
                          //   if(item.name == value){
                          //     statisticCubit.serviceId = item.id;
                          //     statisticCubit.service = value;
                          //     statisticCubit.cabinetId = null;
                          //     statisticCubit.cabinet = null;
                          //     statisticCubit.getChartData(context, widget.navigationPageCubit, 'DONUT');
                          //   }
                          // }

                        },
                        withoutTitle: true,
                        withShadow: true,
                        selectedItem: null,
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
                                isSelected: statisticCubit.currentPosition == 1,
                                title: 'Неделя',
                                onSelected: () {
                                  statisticCubit.changePosition(context, widget.navigationPageCubit, 1, 'LINE');
                                },
                              ),
                              PartColumn(
                                isSelected: statisticCubit.currentPosition == 2,
                                title: 'Месяц',
                                onSelected: () {
                                  statisticCubit.changePosition(context, widget.navigationPageCubit, 2, 'LINE');
                                },
                              ),
                              IconButton(
                                  onPressed: (){
                                    statisticCubit.selectDateRange(context,widget.navigationPageCubit,'LINE');
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

                          if(state is StatisticLineFetingSuccess)
                            if(state.metricReportGroupList.isEmpty)
                              Container(
                                  margin: const EdgeInsets.symmetric(vertical: 30),
                                  child: Text('По указанным критериям нет данных',style: TextStyle(color: AppColors.mainGrey),)
                              ),

                          if(state is StatisticLineFetingSuccess)
                            if(state.lineChartValues.isNotEmpty)
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
                                  isVisible: statisticCubit.listOfMetricValue[0],
                                  numberFormat: NumberFormat.compact(),
                                  minimum: state.lineChartValues[0].values.every((value) => value == 0) ? -1 : null,
                                  maximum: state.lineChartValues[0].values.every((value) => value == 0) ? 1 : null,
                                ),
                                axes: <NumericAxis>[
                                  NumericAxis(
                                    name: 'SecondaryYAxis',
                                    isVisible: statisticCubit.listOfMetricValue[1],
                                    numberFormat: NumberFormat.compact(),
                                    minimum: state.lineChartValues[1].values.every((value) => value == 0) ? -1 : null,
                                    maximum: state.lineChartValues[1].values.every((value) => value == 0) ? 1 : null,
                                  ),
                                  NumericAxis(
                                    name: 'ThirdYAxis',
                                    opposedPosition: true,
                                    isVisible: statisticCubit.listOfMetricValue[2],
                                    numberFormat: NumberFormat.compact(),
                                    minimum: state.lineChartValues[2].values.every((value) => value == 0) ? -1 : null,
                                    maximum: state.lineChartValues[2].values.every((value) => value == 0) ? 1 : null,
                                  ),
                                  NumericAxis(
                                    name: 'FourthYAxis',
                                    opposedPosition: true,
                                    isVisible: statisticCubit.listOfMetricValue[3],
                                    numberFormat: NumberFormat.compact(),
                                    minimum: state.lineChartValues[3].values.every((value) => value == 0) ? -1 : null,
                                    maximum: state.lineChartValues[3].values.every((value) => value == 0) ? 1 : null,
                                  ),
                                ],

                                series: <CartesianSeries>[
                                  if (statisticCubit.listOfMetricValue[0])
                                    SplineAreaSeries<ChartData, DateTime>(
                                      dataSource: statisticCubit.convertData(state.lineChartValues[0]),
                                      xValueMapper: (ChartData data, _) => data.date,
                                      yValueMapper: (ChartData data, _) => data.value,
                                      yAxisName: 'FirstYAxis',
                                      name: 'Series 1',
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          const Color(0xff9A83FF).withOpacity(0.3),
                                          Colors.white,
                                        ].map((color) => color.withOpacity(0.2)).toList(),
                                      ),
                                      borderColor: Color(statisticCubit.colors[0]),
                                      borderWidth: 1,
                                    ),


                                  if (statisticCubit.listOfMetricValue[1])
                                    SplineAreaSeries<ChartData, DateTime>(
                                      dataSource: statisticCubit.convertData(state.lineChartValues[1]),
                                      xValueMapper: (ChartData data, _) => data.date,
                                      yValueMapper: (ChartData data, _) => data.value,
                                      yAxisName: 'SecondaryYAxis',
                                      name: 'Series 2',
                                      color: Color(statisticCubit.colors[1]),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          const Color(0xff9A83FF).withOpacity(0.3),
                                          Colors.white
                                        ].map((color) => color.withOpacity(0.2)).toList(),
                                      ),
                                      borderColor: Color(statisticCubit.colors[1]),
                                      borderWidth: 1,
                                    ),

                                  if (statisticCubit.listOfMetricValue[2])
                                    SplineAreaSeries<ChartData, DateTime>(
                                      dataSource: statisticCubit.convertData(state.lineChartValues[2]),
                                      xValueMapper: (ChartData data, _) => data.date,
                                      yValueMapper: (ChartData data, _) => data.value,
                                      yAxisName: 'ThirdYAxis',
                                      name: 'Series 3',
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          const Color(0xff9A83FF).withOpacity(0.3),
                                          Colors.white
                                        ].map((color) => color.withOpacity(0.2)).toList(),
                                      ),
                                      borderColor: Color(statisticCubit.colors[2]),
                                      borderWidth: 1,
                                    ),

                                  if (statisticCubit.listOfMetricValue[3])
                                    SplineAreaSeries<ChartData, DateTime>(
                                      dataSource: statisticCubit.convertData(state.lineChartValues[3]),
                                      xValueMapper: (ChartData data, _) => data.date,
                                      yValueMapper: (ChartData data, _) => data.value,
                                      yAxisName: 'FourthYAxis',
                                      name: 'Series 4',
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          const Color(0xff9A83FF).withOpacity(0.3),
                                          Colors.white
                                        ].map((color) => color.withOpacity(0.2)).toList(),
                                      ),
                                      borderColor: Color(statisticCubit.colors[3]),
                                      borderWidth: 1,
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                          if(state is StatisticLineFetingSuccess)
                            if(state.metricReportGroupList.isNotEmpty)
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: statisticCubit.firstMetrics.length,
                                  itemBuilder: (context,index){
                                    return Container(
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: DropDownMetrics(
                                          selectedMetric: statisticCubit.firstMetrics[index],
                                          color: Color(statisticCubit.colors[index]),
                                          selected: statisticCubit.listOfMetricValue[index],
                                          onPressed: () {
                                            setState(() {
                                              statisticCubit.listOfMetricValue[index] = !statisticCubit.listOfMetricValue[index];
                                            });
                                          },
                                          metricsValues: state.metricReportGroupList.first.metrics!.toJson(),
                                          onMetricSelected: (value) {
                                            statisticCubit.metricsChanged(state.metricReportGroupList, value,index: index,lineChartValues: state.lineChartValues);
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
          },
        ),
      ),
    );
  }
}


class ChartData {
  final DateTime date;
  final double? value;

  ChartData({required this.date, required this.value});
}