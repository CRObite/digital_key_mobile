
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_box_decoration.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/currency_symbol.dart';
import '../../../../domain/client_contract_service.dart';
import '../../../../widgets/shimmer_box.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import '../review_office_cubit/review_office_cubit.dart';
import '../review_profile.dart';

class CabinetPart extends StatefulWidget {
  const CabinetPart({super.key, required this.navigationPageCubit, required this.query});

  final NavigationPageCubit navigationPageCubit;
  final String query;

  @override
  State<CabinetPart> createState() => _CabinetPartState();
}

class _CabinetPartState extends State<CabinetPart> {

  ScrollController scrollController = ScrollController();
  ReviewOfficeCubit reviewOfficeCubit = ReviewOfficeCubit();

  @override
  void initState() {
    reviewOfficeCubit.getCabinetData(context, widget.query, widget.navigationPageCubit, needLoading: true);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (reviewOfficeCubit.maxPage > reviewOfficeCubit.page + 1) {
          reviewOfficeCubit.page ++;
          reviewOfficeCubit.getCabinetData(context, widget.query, widget.navigationPageCubit);
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
      child: BlocListener(
        bloc: reviewOfficeCubit,
        listener: (context, state) {

        },
        child: BlocBuilder(
          bloc: reviewOfficeCubit,
          builder: (context, state) {

            if(state is ReviewOfficeLoading){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ShimmerBox(width: double.infinity, height: MediaQuery.of(context).size.height * 0.6),
              );
            }

            if(state is ReviewOfficeSuccess){

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  child: Container(
                      width: double.infinity,
                      decoration: AppBoxDecoration.boxWithShadow,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        child: RefreshIndicator(
                          onRefresh: () async {
                            reviewOfficeCubit.resetList(context, widget.query, widget.navigationPageCubit);
                          },
                          child: ListView.builder(
                              controller: scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: state.listOfCCS.length + 1,
                              itemBuilder: (context,index){
                                if(state.listOfCCS.isNotEmpty){
                                  if(index < state.listOfCCS.length){
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            context.push('/cabinetDetails',extra: {'cabinet': state.listOfCCS[index]});
                                          },
                                          child: Container(
                                              width: MediaQuery.of(context).size.width * 0.38,
                                              decoration: const BoxDecoration(
                                                color: Color(0xffF9FAFB),
                                              ),
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(state.listOfCCS[index].name ?? '', style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                                  const SizedBox(height: 5,),
                                                  Row(
                                                    children: [
                                                      SizedBox(width: 18,height: 18,
                                                          child: Image.network(state.listOfCCS[index].service.logo!.url!)
                                                      ),
                                                      const SizedBox(width: 5,),
                                                      Flexible(child: Text(state.listOfCCS[index].service.name ?? '', style: TextStyle(fontSize: 12,color: AppColors.secondaryGreyDarker),)),
                                                    ],
                                                  )
                                                ],
                                              )
                                          ),
                                        ),

                                        Expanded(
                                            child: index == state.listOfCCS.length - 1 ? Scrollbar(
                                                controller: reviewOfficeCubit.scrollControllers[index],
                                                thumbVisibility: true,
                                                child: ScrollableRow(controller: reviewOfficeCubit.scrollControllers[index],clientContractService: state.listOfCCS[index],)
                                            ) : ScrollableRow(controller: reviewOfficeCubit.scrollControllers[index],clientContractService: state.listOfCCS[index],)
                                        )

                                      ],
                                    );
                                  }else{
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                          child: Center(
                                            child: reviewOfficeCubit.maxPage <= reviewOfficeCubit.page + 1
                                                ? Text( state.listOfCCS.length < reviewOfficeCubit.size ? '' : 'Больше нет данных')
                                                : const CircularProgressIndicator(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }else{
                                  return Container(margin:const EdgeInsets.only(top: 30) ,child: const Center(child: Text('Нет данные кабинетов')),);
                                }
                              }
                          ),
                        ),
                      )
                  ),
                ),
              );
            }


            return const SizedBox();
          },
        ),
      ),
    );
  }
}





class ScrollableRow extends StatelessWidget {
  const ScrollableRow({super.key, required this.controller, required this.clientContractService});

  final ScrollController controller;
  final ClientContractService clientContractService;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DoubleTextColumn(text: 'ID аккаунта', text2: clientContractService.adsAccount ?? '-',gap: 5,),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            padding: const EdgeInsets.all(10),
            child: DoubleTextColumn(text: 'Сайт', text2: clientContractService.website ?? '-',gap: 5,),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            padding: const EdgeInsets.all(10),
            child: DoubleTextColumn(text: 'Остаток на аккаунте', text2: '${clientContractService.balance ?? '-'} ${CurrencySymbol.getCurrencySymbol(clientContractService.currency?.code ?? '')}',gap: 5,),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.all(10),
            child: const DoubleTextColumn(text: 'Потрачено с начало месяца', text2: '265,58 \$',gap: 5,),
          ),
        ],
      ),
    );
  }
}