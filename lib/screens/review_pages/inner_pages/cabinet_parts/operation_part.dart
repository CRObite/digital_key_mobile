
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/service_operation_status_enum.dart';
import 'package:web_com/config/service_operation_type_enum.dart';
import 'package:web_com/widgets/shimmer_box.dart';

import '../../../../widgets/deposit_card.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import '../review_office_cubit/review_office_cubit.dart';

class OperationPart extends StatefulWidget {
  const OperationPart({super.key, required this.navigationPageCubit, this.query, this.status, this.type});

  final NavigationPageCubit navigationPageCubit;
  final String? query;
  final ServiceOperationStatus? status;
  final ServiceOperationType? type;

  @override
  State<OperationPart> createState() => _OperationPartState();
}

class _OperationPartState extends State<OperationPart> {

  ScrollController scrollController = ScrollController();
  ReviewOfficeCubit reviewOfficeCubit = ReviewOfficeCubit();

  @override
  void initState() {
    reviewOfficeCubit.getCabinetOperations(context, widget.navigationPageCubit,serviceOperationStatusToJson(widget.status),widget.query,serviceOperationTypeToJson(widget.type),needLoading: true);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (reviewOfficeCubit.maxPage > reviewOfficeCubit.page + 1) {
          reviewOfficeCubit.page ++;
          reviewOfficeCubit.getCabinetOperations(context,widget.navigationPageCubit,serviceOperationStatusToJson(widget.status),widget.query,serviceOperationTypeToJson(widget.type));
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => reviewOfficeCubit,
      child: BlocBuilder(
        bloc: reviewOfficeCubit,
        builder: (context, state) {
          if(state is ReviewOfficeLoading){
            return Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 10,
                  itemBuilder: (context,index){
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                        child: const ShimmerBox(width: double.infinity, height: 200)
                    );
                  }
              ),
            );
          }

          if(state is ReviewOfficeOperationSuccess){
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  reviewOfficeCubit.resetOperationList(context, widget.navigationPageCubit,serviceOperationStatusToJson(widget.status),widget.query,serviceOperationTypeToJson(widget.type));
                },
                child: ListView.builder(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: state.listOfOperations.length + 1,
                    itemBuilder: (context,index){
                      if(state.listOfOperations.isNotEmpty){
                        if(index < state.listOfOperations.length){
                          return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                  onTap: () async {
                                    await context.push('/newOperation',extra: {'operation': state.listOfOperations[index]});
                                    reviewOfficeCubit.resetOperationList(context, widget.navigationPageCubit,serviceOperationStatusToJson(widget.status),widget.query,serviceOperationTypeToJson(widget.type));
                                  },
                                  child: DepositCard(operation: state.listOfOperations[index],)
                              )
                          );
                        }else{
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: reviewOfficeCubit.maxPage <= reviewOfficeCubit.page + 1
                                      ? Text( state.listOfOperations.length < reviewOfficeCubit.size ? '' : 'Больше нет данных')
                                      : CircularProgressIndicator(color: AppColors.secondaryBlueDarker),
                                ),
                              ),
                            ],
                          );
                        }
                      }else{
                        return Container(margin:const EdgeInsets.only(top: 30) ,child: const Center(child: Text('Нет данные зачисления')),);
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