
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/completion_act_status_enum.dart';
import 'package:web_com/config/electronic_invoice_status_enum.dart';
import 'package:web_com/config/invoice_status_enum.dart';
import 'package:web_com/widgets/custom_drop_down.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/shimmer_box.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_icons.dart';
import '../../../widgets/common_tab_bar.dart';
import '../../../widgets/finance_card.dart';
import '../../../widgets/search_app_bar.dart';
import '../../../widgets/status_box.dart';
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
    Tab(text: 'АВР'),
    Tab(text: 'ЭСФ'),
  ];

  int selected = 0;

  bool focused = false;

  String? status;
  String? fromDate;
  String? toDate;
  String? fromAmount;
  String? toAmount;

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(
        focused: focused,
        onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller, isFocused: (value) {
        setState(() {
          focused = value;
        },);
      },),
      body: focused ?
        FinanceFilter(
          statusList:
            selected == 0 ? getInvoiceStatusDescriptions() :
            selected == 1 ? getElectronicInvoiceStatusDescriptions():
            selected == 2 ? getCompletionActStatusDescriptions() : [],
          status: status,
          fromDate: fromDate,
          toDate: toDate,
          fromAmount: fromAmount,
          toAmount: toAmount,
          filterSelected: (String? stat, String? fromDat, String? toDat, String? fromAmou, String? toAmou) {
            setState(() {
              focused = false;
              status = stat;
              fromDate = fromDat;
              toDate = toDat;
              fromAmount = fromAmou;
              toAmount = toAmou;
            });
          },
        ):
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CommonTabBar(tabs: _tabs, onPressed: (value){
                setState(() {
                  selected = value;
                  status = null;
                  fromDate = null;
                  toDate = null;
                  fromAmount = null;
                  toAmount = null;
                });
              }, selectedValue: selected,),
            ),

            if(selected == 0)
              InvoicePart(
                navigationPageCubit:navigationPageCubit,
                status: status != null ? invoiceStatusToJson(getInvoiceStatusByDescription(status)): null,
                fromDate: fromDate,
                toDate: toDate,
                fromAmount: fromAmount,
                toAmount: toAmount,
              ),
            if(selected == 1)
              CompletionActPart(
                navigationPageCubit:navigationPageCubit,
                status: status != null ? completionActStatusToJson(getCompletionActStatusByDescription(status)): null,
                fromDate: fromDate,
                toDate: toDate,
                fromAmount: fromAmount,
                toAmount: toAmount,
              ),
            if(selected == 2)
              ElectronicInvoicePart(
                navigationPageCubit:navigationPageCubit,
                status: status != null ? electronicInvoiceStatusTypeToJson(getElectronicInvoiceStatusByDescription(status)): null,
                fromDate: fromDate,
                toDate: toDate,
                fromAmount: fromAmount,
                toAmount: toAmount,
              ),
          ],
        ),
      floatingActionButton: selected == 0 ? FloatingActionButton(
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
  const InvoicePart({super.key, required this.navigationPageCubit, this.status, this.fromDate, this.toDate, this.fromAmount, this.toAmount});

  final NavigationPageCubit navigationPageCubit;
  final String? status;
  final String? fromDate;
  final String? toDate;
  final String? fromAmount;
  final String? toAmount;


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
          financeDocumentsCubit.getInvoices(context, widget.navigationPageCubit,status: widget.status,fromDate: widget.fromDate,toDate: widget.toDate,fromAmount: widget.fromAmount,toAmount: widget.toAmount);
        }
      }
    });
    super.initState();
  }

  void inStart() async {
    await financeDocumentsCubit.getClient(widget.navigationPageCubit, context);

    if(mounted){
      financeDocumentsCubit.getInvoices(context, widget.navigationPageCubit,needLoading: true,status: widget.status,fromDate: widget.fromDate,toDate: widget.toDate,fromAmount: widget.fromAmount,toAmount: widget.toAmount);
    }

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
                      widget.navigationPageCubit,status: widget.status,fromDate: widget.fromDate,toDate: widget.toDate,fromAmount: widget.fromAmount,toAmount: widget.toAmount
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
                              if(selectingStarted) {
                                setState(() {
                                  state.listOfInvoice[index].selected =
                                  !state.listOfInvoice[index].selected;
                                  if (state.listOfInvoice.every((element) =>
                                  (element).selected == false)) {
                                    selectingStarted = false;
                                  }
                                });
                              }else{
                                context.push('/invoiceDetails',extra: {'invoice': state.listOfInvoice[index]});
                              }

                            },
                            child: FinanceCard(
                              type: FinanceCardType.bill,
                              selected: state.listOfInvoice[index].selected,
                              invoice: state.listOfInvoice[index],
                              onSavePressed: () {

                                financeDocumentsCubit.downloadFile(
                                    context,
                                    state.listOfInvoice[index].id,
                                    widget.navigationPageCubit,
                                    'invoices',
                                    state.listOfInvoice[index].document?.originalName ?? state.listOfInvoice[index].signedDocument?.originalName ?? 'invoiceDocument.pdf'
                                );
                              },
                            ),
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
  const ElectronicInvoicePart({super.key, required this.navigationPageCubit, this.status, this.fromDate, this.toDate, this.fromAmount, this.toAmount});

  final NavigationPageCubit navigationPageCubit;
  final String? status;
  final String? fromDate;
  final String? toDate;
  final String? fromAmount;
  final String? toAmount;

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
          financeDocumentsCubit.getElectronicInvoices(context, widget.navigationPageCubit,status: widget.status,fromDate: widget.fromDate,toDate: widget.toDate,fromAmount: widget.fromAmount,toAmount: widget.toAmount);
        }
      }
    });
    super.initState();
  }

  void inStart() async {
    await financeDocumentsCubit.getClient(widget.navigationPageCubit, context);
    if(mounted){
      financeDocumentsCubit.getElectronicInvoices(context, widget.navigationPageCubit,needLoading: true, status: widget.status,fromDate: widget.fromDate,toDate: widget.toDate,fromAmount: widget.fromAmount,toAmount: widget.toAmount);
    }
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
                      widget.navigationPageCubit,status: widget.status,fromDate: widget.fromDate,toDate: widget.toDate,fromAmount: widget.fromAmount,toAmount: widget.toAmount
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
                          return FinanceCard(
                            type: FinanceCardType.contract,
                            selected: false,
                            electronicInvoice: state.listOfElectronicInvoice[index],
                            onSavePressed: () {
                              financeDocumentsCubit.downloadFile(
                                  context,state.listOfElectronicInvoice[index].id,
                                  widget.navigationPageCubit,
                                  'electronic-invoices',
                                  state.listOfElectronicInvoice[index].document?.originalName ?? 'electronicInvoiceDocument.pdf'
                              );
                            },
                          );
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
                        return Container(margin:const EdgeInsets.only(top: 30) ,child: const Center(child: Text('Нет данных ЭСФ')),);
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
  const CompletionActPart({super.key, required this.navigationPageCubit, this.status, this.fromDate, this.toDate, this.fromAmount, this.toAmount});

  final NavigationPageCubit navigationPageCubit;
  final String? status;
  final String? fromDate;
  final String? toDate;
  final String? fromAmount;
  final String? toAmount;

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
          financeDocumentsCubit.getCompletionActs(context, widget.navigationPageCubit,status: widget.status,fromDate: widget.fromDate,toDate: widget.toDate,fromAmount: widget.fromAmount,toAmount: widget.toAmount);
        }
      }
    });
    super.initState();
  }

  void inStart() async {
    await financeDocumentsCubit.getClient(widget.navigationPageCubit, context);

    financeDocumentsCubit.getCompletionActs(context, widget.navigationPageCubit,needLoading: true,status: widget.status,fromDate: widget.fromDate,toDate: widget.toDate,fromAmount: widget.fromAmount,toAmount: widget.toAmount);
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
                      widget.navigationPageCubit,status: widget.status,fromDate: widget.fromDate,toDate: widget.toDate,fromAmount: widget.fromAmount,toAmount: widget.toAmount
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
                          return FinanceCard(
                            type: FinanceCardType.abp,
                            selected: false,
                            completionAct: state.listOfCompletionAct[index],
                            onSavePressed: () {
                              financeDocumentsCubit.downloadFile(
                                  context,state.listOfCompletionAct[index].id!,
                                  widget.navigationPageCubit,
                                  'completion-acts',
                                  state.listOfCompletionAct[index].document?.originalName ?? state.listOfCompletionAct[index].signedDocument?.originalName ?? 'completionActDocument.pdf'
                              );
                            },
                          );
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
                        return Container(margin:const EdgeInsets.only(top: 30) ,child: const Center(child: Text('Нет данных ABP')),);
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




class FinanceFilter extends StatefulWidget {
  const FinanceFilter({super.key, required this.statusList, this.status, this.fromDate, this.toDate, this.fromAmount, this.toAmount, required this.filterSelected});

  final List<String> statusList;
  final String? status;
  final String? fromDate;
  final String? toDate;
  final String? fromAmount;
  final String? toAmount;
  final Function(
    String? status,
    String? fromDate,
    String? toDate,
    String? fromAmount,
    String? toAmount) filterSelected;



  @override
  State<FinanceFilter> createState() => _FinanceFilterState();
}

class _FinanceFilterState extends State<FinanceFilter> {

  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController fromAmount = TextEditingController();
  TextEditingController toAmount = TextEditingController();

  String? selectedStatus;
  double fromValue = 0;
  double toValue = 10000000;


  @override
  void initState() {
    selectedStatus = widget.status;
    fromDate.text = widget.fromDate ?? '';
    toDate.text = widget.toDate ?? '';
    fromAmount.text = widget.fromAmount ?? '';
    toAmount.text = widget.toAmount ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Фильтр', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Flexible(flex: 2,child: TitledField(controller: fromDate, title: 'Диапазон дат', type: TextInputType.datetime, hint:'От',)),
                    const SizedBox(width: 10,),
                    Flexible(flex: 2,child: TitledField(controller: toDate, title: '', type: TextInputType.datetime, hint:'До',)),
                  ],
                ),
                const SizedBox(height: 10,),
                const Text('Статус', style: TextStyle(fontSize: 12, color: Colors.black),),
                const SizedBox(height: 10,),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: widget.statusList.map((status) {
                    return StatusBox(color: AppColors.secondaryBlueDarker, text: status,selected: selectedStatus == status,onPressed: (){
                        setState(() {
                          if(selectedStatus == status){
                            selectedStatus = null;
                          }else{
                            selectedStatus = status;
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Flexible(flex: 2,child: TitledField(controller: fromAmount, title: 'Сумма', type: TextInputType.number, hint:'От',)),
                    const SizedBox(width: 10,),
                    Flexible(flex: 2,child: TitledField(controller: toAmount, title: '', type: TextInputType.number, hint:'До',)),
                  ],
                ),
        
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RangeSlider(
                    min: 0,
                    max: 10000000,
                    values: RangeValues(fromValue, toValue),
                    onChanged: (RangeValues values) {
                      setState(() {
                        fromValue = values.start;
                        toValue = values.end;
                        fromAmount.text = values.start.toStringAsFixed(0);
                        toAmount.text = values.end.toStringAsFixed(0);
                      });
                    },
        
                    inactiveColor: AppColors.mainGrey,
                    activeColor: AppColors.secondaryBlueDarker,
                  ),
                ),
              ],
            ),
        
            ExpandedButton(onPressed: (){
              widget.filterSelected(
                  selectedStatus,
                  fromDate.text,
                  toDate.text,
                  fromAmount.text,
                  toAmount.text
              );
            }, child: const Text('Применить',style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );
  }
}
