
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/domain/client_contract_service.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_statistic_cubit/review_statistic_cubit.dart';
import 'package:web_com/widgets/shimmer_box.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_icons.dart';
import '../../../config/app_texts.dart';
import '../../../config/currency_symbol.dart';
import '../../../widgets/months_builder.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class ReviewStatistics extends StatefulWidget {
  const ReviewStatistics({super.key});

  @override
  State<ReviewStatistics> createState() => _ReviewStatisticsState();
}

class _ReviewStatisticsState extends State<ReviewStatistics> {

  int selectedMonth = 0;
  late int currentMonthIndex;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    currentMonthIndex = now.month - 1;
    selectedMonth = currentMonthIndex;

  }


  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller,isFocused: (value) {  },),
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

          ProfileStatisticBody(navigationPageCubit: navigationPageCubit,)
        ],
      ),
    );
  }
}


class ProfileStatisticBody extends StatefulWidget {
  const ProfileStatisticBody({super.key, required this.navigationPageCubit});

  final NavigationPageCubit  navigationPageCubit;

  @override
  State<ProfileStatisticBody> createState() => _ProfileStatisticBodyState();
}

class _ProfileStatisticBodyState extends State<ProfileStatisticBody> {

  ReviewStatisticCubit reviewStatisticCubit = ReviewStatisticCubit();

  @override
  void initState() {
    getCubitData();
    super.initState();
  }

  Future<void> getCubitData() async {
    await reviewStatisticCubit.getClientData(context, widget.navigationPageCubit);
    reviewStatisticCubit.getServiceData(context, widget.navigationPageCubit);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => reviewStatisticCubit,
      child: BlocBuilder(
        bloc: reviewStatisticCubit,
        builder: (context, state) {

          if(state is ReviewStatisticLoading){
            return Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const ShimmerBox(width: double.infinity, height: 100)
                    );
                  }),
            );
          }

          if(state is ReviewStatisticSuccess){


            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  reviewStatisticCubit.resetList(context, widget.navigationPageCubit);
                },
                child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.listOfCCS.length + 1,
                    itemBuilder: (context,index){
                      if(state.listOfCCS.isNotEmpty){
                        if(index < state.listOfCCS.length){
                          return StatisticCard(clientContractService: state.listOfCCS[index], clientId: reviewStatisticCubit.client!.id!,);
                        }else{
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: reviewStatisticCubit.maxPage <= reviewStatisticCubit.page + 1
                                      ? Text( state.listOfCCS.length < reviewStatisticCubit.size ? '' : 'Больше нет данных')
                                      : const CircularProgressIndicator(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 90),
                            ],
                          );
                        }
                      }else{
                        return Container(margin:const EdgeInsets.only(top: 30) ,child: const Center(child: Text('Нет данные сервисов')),);
                      }
                    }
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class StatisticCard extends StatefulWidget {
  const StatisticCard({super.key, required this.clientContractService, required this.clientId,});

  final ClientContractService clientContractService;
  final int clientId;

  @override
  State<StatisticCard> createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard> {

  // Future<void> getMetricsGroup(BuildContext context,NavigationPageCubit navigationPageCubit) async {
  //
  //   try{
  //     List<MetricReportGroup> metricReportGroupList = await MetricsRepository().getMetrics(context,"LINE",widget.clientId,serviceId: widget.clientContractService.serviceId);
  //     print(metricReportGroupList.first.metrics)
  //
  //   }catch(e){
  //     if(e is DioException){
  //       CustomException exception = CustomException.fromDioException(e);
  //
  //       navigationPageCubit.showMessage(exception.message, false);
  //     }else{
  //       rethrow;
  //     }
  //   }
  // }
  //
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push('/statisticDetails');
      },
      child: Row(
        children: [
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: Image.network(
                  widget.clientContractService.service.logo?.url ?? '',
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
                    widget.clientContractService.service.name ?? '',
                    style: TextStyle(
                        color: Colors.grey.shade600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.clientContractService.balance ?? '-'} ${CurrencySymbol.getCurrencySymbol(widget.clientContractService.currency?.code ?? '')}',
                  ),
                ],
              )
            ],
          ),

          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 30.0),
          //     child: SizedBox(
          //       height: 35,
          //       child: LineChart(
          //         LineChartData(
          //           gridData: const FlGridData(show: false),
          //           titlesData: const FlTitlesData(show: false),
          //           borderData: FlBorderData(show: false),
          //           minX: 0,
          //           minY: 0,
          //           lineTouchData: const LineTouchData(enabled: false),
          //           lineBarsData: [
          //             LineChartBarData(
          //               color: AppColors.blueForMetricColor,
          //               spots: grafOneData.asMap().entries.map((e) {
          //                 return FlSpot(e.key.toDouble(), e.value.toDouble());
          //               }).toList(),
          //               isCurved: false,
          //               barWidth: 1.5,
          //               isStrokeCapRound: false,
          //               dotData: const FlDotData(show: false),
          //               belowBarData: BarAreaData(show: false),
          //             ),
          //             LineChartBarData(
          //               color: AppColors.blueForMetricSecondColor,
          //               spots: grafTwoData.asMap().entries.map((e) {
          //                 return FlSpot(e.key.toDouble(), e.value.toDouble());
          //               }).toList(),
          //               isCurved: false,
          //               barWidth: 1.5,
          //               isStrokeCapRound: false,
          //               dotData: const FlDotData(show: false),
          //               belowBarData: BarAreaData(show: false),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

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
  }
}
