import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/domain/client_contract_service.dart';
import 'package:web_com/screens/review_pages/inner_pages/cabinet_details_cubit/cabinet_details_cubit.dart';
import 'package:web_com/widgets/shimmer_box.dart';

import '../../../config/app_icons.dart';
import '../../../widgets/deposit_card.dart';
import '../../../widgets/go_back_row.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class EnrollmentHistory extends StatefulWidget {
  const EnrollmentHistory({super.key, required this.ccs});

  final ClientContractService ccs;

  @override
  State<EnrollmentHistory> createState() => _EnrollmentHistoryState();
}

class _EnrollmentHistoryState extends State<EnrollmentHistory> {

  TextEditingController textController =TextEditingController();
  FocusNode focusNode = FocusNode();

  CabinetDetailsCubit cabinetDetailsCubit = CabinetDetailsCubit();


  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);
    cabinetDetailsCubit.getCabinetOperations(context, navigationPageCubit, widget.ccs.id,needLoading: true);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (cabinetDetailsCubit.maxPage > cabinetDetailsCubit.page + 1) {
          cabinetDetailsCubit.page ++;
          cabinetDetailsCubit.getCabinetOperations(context, navigationPageCubit, widget.ccs.id);
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

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: textController, isFocused: (value) {  }),

      body: BlocProvider(
        create: (context) => cabinetDetailsCubit,
        child: BlocBuilder(
          bloc: cabinetDetailsCubit,
          builder: (context, state) {
            return  Column(
              children: [
                const GoBackRow(title: 'История зачислений'),

                const SizedBox(height: 10,),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      cabinetDetailsCubit.resetOperationList(context, navigationPageCubit, widget.ccs.id);
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                widget.ccs.service.logo?.url != null ? SizedBox(height: 20, child: Image.network(widget.ccs.service.logo!.url!)) : const SizedBox(),
                                const SizedBox(width: 5,),
                                Flexible(child: Text(widget.ccs.name ?? '', style: TextStyle(color: AppColors.secondaryGreyDarker),maxLines: 1,overflow: TextOverflow.ellipsis,))
                              ],
                            ),
                          ),
                  
                          const SizedBox(height: 10,),
                  
                          if(state is CabinetDetailsLoading)
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                itemCount: 10,
                                itemBuilder: (context,index){
                                  return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      child: const ShimmerBox(width: double.infinity, height: 200)
                                  );
                                }
                            ),
                  
                          if(state is CabinetDetailsFetched)
                            ListView.builder(
                                shrinkWrap: true,
                                controller: scrollController,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                itemCount: state.listOfOperation.length + 1,
                                itemBuilder: (context,index){
                                  if(state.listOfOperation.isNotEmpty){
                                    if(index < state.listOfOperation.length){
                                      return Container(
                                          margin: const EdgeInsets.only(bottom: 10),
                                          child: DepositCard(operation: state.listOfOperation[index],)
                                      );
                                    }else{
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 16),
                                            child: Center(
                                              child: cabinetDetailsCubit.maxPage <= cabinetDetailsCubit.page + 1
                                                  ? Text( state.listOfOperation.length < cabinetDetailsCubit.size ? '' : 'Больше нет данных')
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
                            )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () { context.push('/newOperation'); },
        child: SvgPicture.asset(AppIcons.addContract),
      ),
    );
  }
}
