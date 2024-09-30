import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/data/repository/file_repository.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_office_cubit/review_office_cubit.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile.dart';
import 'package:web_com/widgets/shimmer_box.dart';
import 'package:web_com/widgets/status_box.dart';

import '../../../config/app_box_decoration.dart';
import '../../../config/app_icons.dart';
import '../../../domain/client_contract_service.dart';
import '../../../widgets/common_tab_bar.dart';
import '../../../widgets/deposit_card.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class ReviewOffice extends StatefulWidget {
  const ReviewOffice({super.key});

  @override
  State<ReviewOffice> createState() => _ReviewOfficeState();
}

class _ReviewOfficeState extends State<ReviewOffice> {

  int selected = 0;
  TextEditingController controller = TextEditingController();

  bool focused = false;

  final _tabs = const [
    Tab(text: 'Кабинеты'),
    Tab(text: 'Зачисление'),
  ];

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller,isFocused: (value) {
        setState(() {
          focused = value;
        });
      },),
      body: focused ? const FilterFocused():Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CommonTabBar(tabs: _tabs, onPressed: (value){
              setState(() {
                selected = value;
              });
            }),
          ),

          if(selected == 0)
            CabinetPart(navigationPageCubit: navigationPageCubit, query: '',),

          if(selected == 1)
            const OperationPart()
        ],
      ),

      floatingActionButton: selected == 1 ? FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        heroTag: 'addChanges',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: false,
        onPressed: () { context.push('/newOperation'); },
        child: SvgPicture.asset(AppIcons.addContract),
      ) : null,
    );
  }
}


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
        if (reviewOfficeCubit.maxPage >= reviewOfficeCubit.page + 1) {
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
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: state.listOfCCS.length + 1,
                              itemBuilder: (context,index){
                                if(state.listOfCCS.isNotEmpty){
                                  if(index < state.listOfCCS.length){
                                    return Row(
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            context.push('/cabinetDetails');
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
                                                          child: Image.network('http://185.102.74.90:8060/api/files/${Uri.parse(state.listOfCCS[index].service.logo!.url!).pathSegments[2]}/public' )
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
                                        const SizedBox(height: 90),
                                      ],
                                    );
                                  }
                                }else{
                                  return Container(margin:const EdgeInsets.only(top: 30) ,child: const Center(child: Text('Нет данные кабинетов',style: TextStyle(color: Colors.white,fontSize: 20),)),);
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


class OperationPart extends StatelessWidget {
  const OperationPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 10,
          itemBuilder: (context,index){
            return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const DepositCard()
            );
          }
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DoubleTextColumn(text: 'ID аккаунта', text2: clientContractService.adsAccount ?? '-',gap: 5,),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: DoubleTextColumn(text: 'Сайт', text2: clientContractService.website ?? '-',gap: 5,),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: DoubleTextColumn(text: 'Остаток на аккаунте', text2: '${clientContractService.balance ?? '-'} \$',gap: 5,),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const DoubleTextColumn(text: 'Потрачено с начало месяца', text2: '265,58 \$',gap: 5,),
          ),
        ],
      ),
    );
  }
}


class FilterFocused extends StatelessWidget {
  const FilterFocused({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Сортировать',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    StatusBox(color: AppColors.secondaryBlueDarker, text: 'по названию'),
                    const SizedBox(width: 5,),
                    StatusBox(color: AppColors.secondaryBlueDarker, text: 'по названию'),
                    const SizedBox(width: 5,),
                    StatusBox(color: AppColors.secondaryBlueDarker, text: 'по названию'),
                  ],
                ),
                const SizedBox(height: 10,),
                const Text('Операции',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    StatusBox(color: AppColors.secondaryBlueDarker, text: 'все'),
                    const SizedBox(width: 5,),
                    StatusBox(color: AppColors.secondaryBlueDarker, text: 'все'),
                    const SizedBox(width: 5,),
                    StatusBox(color: AppColors.secondaryBlueDarker, text: 'все'),
                  ],
                ),
                const SizedBox(height: 10,),
                const Text('Рекламные кабинеты',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
              ],
            ),
          ),

          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 160/40
              ),
              itemCount: 8,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: AppBoxDecoration.boxWithShadow,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: Image.asset('assets/images/vk.png'),
                      ),
                      const SizedBox(width: 5,),
                      Text('Реклама Vk',style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondaryGreyDarker),)
                    ],
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
