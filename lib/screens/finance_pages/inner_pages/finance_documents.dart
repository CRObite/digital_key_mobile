
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/widgets/custom_drop_down.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/shimmer_box.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_icons.dart';
import '../../../widgets/common_tab_bar.dart';
import '../../../widgets/finance_card.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import 'finance_documents_cubit/finance_documents_cubit.dart';

class FinanceDocuments extends StatefulWidget {
  const FinanceDocuments({super.key});

  @override
  State<FinanceDocuments> createState() => _FinanceDocumentsState();
}

class _FinanceDocumentsState extends State<FinanceDocuments> {



  TextEditingController controller = TextEditingController();
  TextEditingController controllerFrom =TextEditingController();
  TextEditingController controllerTo =TextEditingController();

  bool selectingStarted = false;

  final _tabs = const [
    Tab(text: 'Счет'),
    Tab(text: 'ЭСФ'),
    Tab(text: 'АВР'),
  ];

  int selected = 0;

  bool focused = false;

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller, isFocused: (value) {
        setState(() {
          focused = value;
        });
      },),
      body: focused ? FinanceFilter(controllerFrom: controllerFrom, controllerTo: controllerTo,): Column(
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
            InvoicePart(navigationPageCubit:navigationPageCubit),
          if(selected == 1)
            ElectronicInvoicePart(navigationPageCubit:navigationPageCubit),
          if(selected == 2)
            CompletionActPart(navigationPageCubit:navigationPageCubit)
        ],
      ),
      floatingActionButton: selected != 0 ? FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () {  },
        child: SvgPicture.asset(AppIcons.addContract),
      ): selectingStarted ? FloatingActionButton(
        backgroundColor: Colors.red.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: false,
        onPressed: () {  },
        child: SvgPicture.asset(AppIcons.delete, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),),
      ): null,

    );
  }
}



class InvoicePart extends StatefulWidget {
  const InvoicePart({super.key, required this.navigationPageCubit});

  final NavigationPageCubit navigationPageCubit;

  @override
  State<InvoicePart> createState() => _InvoicePartState();
}

class _InvoicePartState extends State<InvoicePart> {


  bool selectingStarted = false;
  ScrollController scrollController = ScrollController();
  FinanceDocumentsCubit financeDocumentsCubit = FinanceDocumentsCubit();

  @override
  void initState() {
    inStart();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (financeDocumentsCubit.maxPage > financeDocumentsCubit.page + 1) {
          financeDocumentsCubit.page ++;
          financeDocumentsCubit.getInvoices(context, widget.navigationPageCubit);
        }
      }
    });
    super.initState();
  }

  void inStart() async {
    await financeDocumentsCubit.getClient(widget.navigationPageCubit, context);
    financeDocumentsCubit.getInvoices(context, widget.navigationPageCubit,needLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => financeDocumentsCubit,
      child: BlocBuilder(
        bloc: financeDocumentsCubit,
        builder: (context, state) {
          if(state is FinanceDocumentsLoading){
            return Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context,index){
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const ShimmerBox(width: double.infinity, height: 150)
                    );
                  }
              ),
            );
          }


          if(state is FinanceDocumentsSuccess){

            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  financeDocumentsCubit.resetInvoiceList(
                      context,
                      widget.navigationPageCubit,
                  );
                },
                child: ListView.builder(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.listOfInvoice.length + 1,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context,index){

                      if(state.listOfInvoice.isNotEmpty){
                        if(index < state.listOfInvoice.length){
                          return GestureDetector(
                            onLongPress: (){


                              if(!selectingStarted){
                                setState(() {
                                  state.listOfInvoice[index].selected = !state.listOfInvoice[index].selected;
                                  selectingStarted = true;
                                });
                              }


                            },
                            onTap: (){
                              if(selectingStarted){
                                setState(() {
                                  state.listOfInvoice[index].selected = !state.listOfInvoice[index].selected;
                                  if(state.listOfInvoice.every((element) => (element).selected == false)){
                                    selectingStarted = false;
                                  }
                                });
                              }

                            },
                            child: FinanceCard(type: FinanceCardType.bill, selected: state.listOfInvoice[index].selected,invoice: state.listOfInvoice[index],),
                          );
                        }else{
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: financeDocumentsCubit.maxPage <= financeDocumentsCubit.page + 1
                                      ? Text( state.listOfInvoice.length < financeDocumentsCubit.size ? '' : 'Больше нет данных')
                                      : CircularProgressIndicator(color: AppColors.secondaryBlueDarker),
                                ),
                              ),
                              const SizedBox(height: 90),
                            ],
                          );
                        }
                      }else{
                        return Container(margin:const EdgeInsets.only(top: 30) ,child: const Center(child: Text('Нет данных счетов')),);
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

class ElectronicInvoicePart extends StatefulWidget {
  const ElectronicInvoicePart({super.key, required this.navigationPageCubit});

  final NavigationPageCubit navigationPageCubit;

  @override
  State<ElectronicInvoicePart> createState() => _ElectronicInvoicePartState();
}

class _ElectronicInvoicePartState extends State<ElectronicInvoicePart> {

  ScrollController scrollController = ScrollController();
  FinanceDocumentsCubit financeDocumentsCubit = FinanceDocumentsCubit();

  @override
  void initState() {
    inStart();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (financeDocumentsCubit.maxPage > financeDocumentsCubit.page + 1) {
          financeDocumentsCubit.page ++;
          financeDocumentsCubit.getElectronicInvoices(context, widget.navigationPageCubit);
        }
      }
    });
    super.initState();
  }

  void inStart() async {
    await financeDocumentsCubit.getClient(widget.navigationPageCubit, context);
    financeDocumentsCubit.getElectronicInvoices(context, widget.navigationPageCubit,needLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => financeDocumentsCubit,
      child: BlocBuilder(
        bloc: financeDocumentsCubit,
        builder: (context, state) {
          if(state is FinanceDocumentsLoading){
            return Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context,index){
                    return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const ShimmerBox(width: double.infinity, height: 150)
                    );
                  }
              ),
            );
          }


          if(state is FinanceDocumentsSuccess){


            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  financeDocumentsCubit.resetElectronicInvoiceList(
                      context,
                      widget.navigationPageCubit,
                  );
                },
                child: ListView.builder(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.listOfElectronicInvoice.length + 1,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context,index){

                      if(state.listOfElectronicInvoice.isNotEmpty){
                        if(index < state.listOfElectronicInvoice.length){
                          return FinanceCard(type: FinanceCardType.contract, selected: false,electronicInvoice: state.listOfElectronicInvoice[index],);
                        }else{
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: financeDocumentsCubit.maxPage <= financeDocumentsCubit.page + 1
                                      ? Text( state.listOfElectronicInvoice.length < financeDocumentsCubit.size ? '' : 'Больше нет данных')
                                      : CircularProgressIndicator(color: AppColors.secondaryBlueDarker),
                                ),
                              ),
                              const SizedBox(height: 90),
                            ],
                          );
                        }
                      }else{
                        return Container(margin:const EdgeInsets.only(top: 30) ,child: const Center(child: Text('Нет данных счетов')),);
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


class CompletionActPart extends StatefulWidget {
  const CompletionActPart({super.key, required this.navigationPageCubit});

  final NavigationPageCubit navigationPageCubit;

  @override
  State<CompletionActPart> createState() => _CompletionActPartState();
}

class _CompletionActPartState extends State<CompletionActPart> {
  ScrollController scrollController = ScrollController();
  FinanceDocumentsCubit financeDocumentsCubit = FinanceDocumentsCubit();

  @override
  void initState() {
    inStart();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (financeDocumentsCubit.maxPage > financeDocumentsCubit.page + 1) {
          financeDocumentsCubit.page ++;
          financeDocumentsCubit.getCompletionActs(context, widget.navigationPageCubit);
        }
      }
    });
    super.initState();
  }

  void inStart() async {
    await financeDocumentsCubit.getClient(widget.navigationPageCubit, context);

    financeDocumentsCubit.getCompletionActs(context, widget.navigationPageCubit,needLoading: true);
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => financeDocumentsCubit,
      child: BlocBuilder(
        bloc: financeDocumentsCubit,
        builder: (context, state) {
          if(state is FinanceDocumentsLoading){
            return Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context,index){
                    return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const ShimmerBox(width: double.infinity, height: 150)
                    );
                  }
              ),
            );
          }


          if(state is FinanceDocumentsSuccess){

            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  financeDocumentsCubit.resetCompletionActsList(
                      context,
                      widget.navigationPageCubit,
                  );
                },
                child: ListView.builder(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.listOfCompletionAct.length + 1,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context,index){

                      if(state.listOfCompletionAct.isNotEmpty){
                        if(index < state.listOfCompletionAct.length){
                          return FinanceCard(type: FinanceCardType.abp, selected: false,completionAct: state.listOfCompletionAct[index],);
                        }else{
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: financeDocumentsCubit.maxPage <= financeDocumentsCubit.page + 1
                                      ? Text( state.listOfCompletionAct.length < financeDocumentsCubit.size ? '' : 'Больше нет данных')
                                      : CircularProgressIndicator(color: AppColors.secondaryBlueDarker),
                                ),
                              ),
                              const SizedBox(height: 90),
                            ],
                          );
                        }
                      }else{
                        return Container(margin:const EdgeInsets.only(top: 30) ,child: const Center(child: Text('Нет данных счетов')),);
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




class FinanceFilter extends StatelessWidget {
  const FinanceFilter({super.key, required this.controllerFrom, required this.controllerTo});

  final TextEditingController controllerFrom;
  final TextEditingController controllerTo;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Фильтр', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              CustomDropDown(title: 'Дата выставления', dropDownList: const [], onSelected: (value){}, hint: 'Счет',),
              const SizedBox(height: 10,),
              CustomDropDown(title: 'Договор', dropDownList: const [], onSelected: (value){},hint: 'Счет',),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Flexible(flex: 2,child: TitledField(controller: controllerFrom, title: 'Сумма', type: TextInputType.number, hint:'От',)),
                  const SizedBox(width: 10,),
                  Flexible(flex: 2,child: TitledField(controller: controllerTo, title: '', type: TextInputType.number, hint:'До',)),
                ],
              ),
            ],
          ),

          ExpandedButton(onPressed: (){

          }, child: const Text('Применить',style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }
}
