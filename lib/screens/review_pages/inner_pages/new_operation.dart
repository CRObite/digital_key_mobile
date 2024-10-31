
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/config/app_box_decoration.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/app_formatter.dart';
import 'package:web_com/config/currency_symbol.dart';
import 'package:web_com/config/service_operation_status_enum.dart';
import 'package:web_com/data/repository/contract_repository.dart';
import 'package:web_com/domain/client_contract_service.dart';
import 'package:web_com/domain/service.dart';
import 'package:web_com/domain/service_operation.dart';
import 'package:web_com/screens/review_pages/inner_pages/new_operation_cubit/new_operation_cubit.dart';
import 'package:web_com/widgets/custom_drop_down.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/shimmer_box.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../../config/service_operation_type_enum.dart';
import '../../../data/repository/service_repository.dart';
import '../../../domain/contract.dart';
import '../../../utils/custom_exeption.dart';
import '../../../widgets/go_back_row.dart';
import '../../../widgets/lazy_drop_down.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class NewOperation extends StatefulWidget {
  const NewOperation({super.key, required this.operation});

  final ServiceOperation? operation;

  @override
  State<NewOperation> createState() => _NewOperationState();
}

class _NewOperationState extends State<NewOperation> {
  TextEditingController textController =TextEditingController();
  TextEditingController textController2 =TextEditingController();


  NewOperationCubit newOperationCubit = NewOperationCubit();

  Contract? contract;
  ServiceOperationType? type;


  int selected = 0;

  @override
  void initState() {
    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    if(widget.operation != null){
      newOperationCubit.alreadyHasOperation(context,navigationPageCubit,widget.operation!);
      firstService = widget.operation!.fromService?.service;
      firstCabinet = widget.operation!.fromService;
      secondService = widget.operation!.toService?.service;
      secondCabinet = widget.operation!.toService;
      textController2.text = widget.operation?.amount !=  null ? '${widget.operation?.amount}': '';
    }else{
      newOperationCubit.getInitData(context, navigationPageCubit);
    }

    super.initState();
  }

  FocusNode focusNode = FocusNode();

  Service? firstService;
  ClientContractService? firstCabinet;
  Service? secondService;
  ClientContractService? secondCabinet;

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: textController, isFocused: (value ) {  },),

      body: BlocProvider(
        create: (context) => newOperationCubit,
        child: BlocBuilder(
          bloc: newOperationCubit,
          builder: (context, state) {
            return Column(
              children: [
                const GoBackRow(title: 'Новое зачислений'),

                const SizedBox(height: 20,),

                if(state is NewOperationLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        ShimmerBox(width: double.infinity, height: 50),
                        SizedBox(height: 20,),
                        ShimmerBox(width: double.infinity, height: 50),
                      ],
                    ),
                  ),

                if(state is NewOperationFirstStep)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CustomDropDown(
                                title: 'Выберите тип зачисления',
                                dropDownList: getServiceOperationTypeDescriptions(),
                                onSelected: (value){
                                  type = serviceOperationTypeFromDescription(value);
                                }
                            ),
                            const SizedBox(height: 10),
                            LazyDropDown(
                              navigationPageCubit: navigationPageCubit,
                              selected: (Contract? value) {
                                contract = value;
                              },
                              currentValue: null,
                              title: 'Выберите договор',
                              important: false,
                              getData: (int page, int size, String query) => ContractRepository.getContractsByClientId(
                                  context, state.client.id!, page, size, query: query, active: true),
                              fromJson: (json) => Contract.fromJson(json),
                              fieldName: 'number',
                              toJson: (contract) => contract!.toJson(),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ExpandedButton(
                            child: const Text(
                              'Далее',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if(type != null && contract != null){
                                newOperationCubit.passFirstStage(context, navigationPageCubit, type!, contract!,state.client);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),


                if(state is NewOperationSecondStep)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: AppBoxDecoration.boxWithShadow,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text.rich(
                              TextSpan(
                                text: state.operation.type?.description ?? '',
                                children: [
                                  TextSpan(
                                    text: ' №${state.operation.id}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),

                          const SizedBox(height: 10,),

                          LazyDropDown(
                            navigationPageCubit: navigationPageCubit,
                            selected: (Service? value) {
                              setState(() {
                                if(state.operation.type == ServiceOperationType.FUND){
                                  secondService = value;
                                  secondCabinet = null;
                                }else{
                                  firstService = value;
                                  firstCabinet = null;
                                }
                              });
                            },
                            currentValue: state.operation.type == ServiceOperationType.FUND ? secondService : firstService,
                            title: 'Сервис',
                            important: false,
                            getData: (int page, int size, String query) => ServiceRepository().getAllService(context, page, size, query),
                            fromJson: (json) => Service.fromJson(json),
                            fieldName: 'name',
                            toJson: (service) => service.toJson(),
                          ),
                          const SizedBox(height: 10,),

                            LazyDropDown(
                              navigationPageCubit: navigationPageCubit,
                              selected: (ClientContractService? value) {
                                setState(() {
                                  if(state.operation.type == ServiceOperationType.FUND){
                                    secondCabinet = value;
                                    secondService ??= value?.service;
                                  }else{
                                    firstCabinet = value;
                                    firstService ??= value?.service;
                                  }
                                });
                              },
                              currentValue: state.operation.type == ServiceOperationType.FUND ? secondCabinet : firstCabinet,
                              title: 'Кабинет',
                              important: false,
                              getData: (int page, int size, String query) => ContractRepository.getContractService(context, query, page, size,clientId: state.client.id,serviceId: state.operation.type == ServiceOperationType.FUND ? secondService?.id : firstService?.id,contractId: state.operation.contractId),
                              fromJson: (json) => ClientContractService.fromJson(json),
                              fieldName: 'name',
                              toJson: (cabinet) => cabinet.toJson(),
                            ),
                            const SizedBox(height: 10,),

                          if(state.operation.type == ServiceOperationType.FUND && secondCabinet!= null)
                            CurrentBalance(
                                textWidget: Text(secondCabinet?.balance != null ?
                                AppFormatter().formatCurrency(
                                    secondCabinet!.balance!,
                                    secondCabinet?.currency?.code != null ? CurrencySymbol.getCurrencySymbol(secondCabinet!.currency!.code!): '',
                                    0
                                ) : '',style: const TextStyle(fontSize: 12),),
                              contractId: state.operation.contract!.id!,
                              contractServiceId: secondCabinet!.id,
                              navigationPageCubit: navigationPageCubit,
                            ),

                          if(state.operation.type != ServiceOperationType.FUND  && firstCabinet!= null)
                            CurrentBalance(
                                textWidget: Text(firstCabinet?.balance != null ?
                                AppFormatter().formatCurrency(
                                    firstCabinet!.balance!,
                                    firstCabinet?.currency?.code != null ? CurrencySymbol.getCurrencySymbol(firstCabinet!.currency!.code!): '',
                                    0
                                ) : '',style: const TextStyle(fontSize: 12),),
                              contractId: state.operation.contract!.id!,
                              contractServiceId: firstCabinet!.id,
                              navigationPageCubit: navigationPageCubit,
                            ),

                          const SizedBox(height: 15,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(child: Divider(color: AppColors.borderGrey,)),
                                  const SizedBox(width: 10,),
                                  SvgPicture.asset('assets/icons/ic_swap.svg'),
                                  const SizedBox(width: 10,),
                                  Expanded(child: Divider(color: AppColors.borderGrey,)),
                                ],
                              ),
                            ),
                          ),

                          if(state.operation.type == ServiceOperationType.TRANSFER)
                            ...[
                              LazyDropDown(
                                navigationPageCubit: navigationPageCubit,
                                selected: (Service? value) {
                                  setState(() {
                                    secondService = value;
                                    secondCabinet = null;
                                  });
                                },
                                currentValue: secondService,
                                title: 'Сервис',
                                important: false,
                                getData: (int page, int size, String query) => ServiceRepository().getAllService(context, page, size, query),
                                fromJson: (json) => Service.fromJson(json),
                                fieldName: 'name',
                                toJson: (service) => service.toJson(),
                              ),
                              const SizedBox(height: 10,),

                                LazyDropDown(
                                  navigationPageCubit: navigationPageCubit,
                                  selected: (ClientContractService? value) {
                                    setState(() {
                                      secondCabinet = value;
                                      secondService ??= value?.service;
                                    });
                                  },
                                  currentValue: secondCabinet,
                                  title: 'Кабинет',
                                  important: false,
                                  getData: (int page, int size, String query) => ContractRepository.getContractService(context, query, page, size,clientId: state.client.id,serviceId: secondService?.id, contractId: state.operation.contractId),
                                  fromJson: (json) => ClientContractService.fromJson(json),
                                  fieldName: 'name',
                                  toJson: (cabinet) => cabinet.toJson(),
                                ),

                                const SizedBox(height: 10,),

                              if(secondCabinet != null)
                                CurrentBalance(
                                    textWidget: Text(secondCabinet?.balance != null ?
                                    AppFormatter().formatCurrency(
                                        secondCabinet!.balance!,
                                        secondCabinet?.currency?.code != null ? CurrencySymbol.getCurrencySymbol(secondCabinet!.currency!.code!): '',
                                        0
                                    ) : '',style: const TextStyle(fontSize: 12),),
                                  contractId: state.operation.contract!.id!,
                                  contractServiceId: secondCabinet!.id,
                                  navigationPageCubit: navigationPageCubit,
                                )
                            ],
                          const SizedBox(height: 10,),
                          TitledField(controller: textController2, title: 'Сумма', type: TextInputType.number, hint: 'Введите сумму',),
                          const SizedBox(height: 15,),

                          if(state.operation.status == ServiceOperationStatus.NEW)
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ExpandedButton(
                                  innerPaddingY: 10,
                                  child: const Text('Перевести', style: TextStyle(color: Colors.white),),
                                  onPressed: (){
                                    if(state.operation.type == ServiceOperationType.FUND){
                                      newOperationCubit.passSecondStage(
                                          context,
                                          navigationPageCubit,
                                          state.operation,
                                          double.parse(textController2.text),
                                          secondCabinet,
                                          null,
                                          state.client
                                      );
                                    }else if(state.operation.type == ServiceOperationType.REFUND){
                                      newOperationCubit.passSecondStage(
                                          context,
                                          navigationPageCubit,
                                          state.operation,
                                          double.parse(textController2.text),
                                          firstCabinet,
                                          null,
                                          state.client
                                      );
                                    }else{
                                      newOperationCubit.passSecondStage(
                                          context,
                                          navigationPageCubit,
                                          state.operation,
                                          double.parse(textController2.text),
                                          firstCabinet,
                                          secondCabinet,
                                          state.client
                                      );
                                    }
                                  }
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.mainBlue,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(60.0),
      //   ),
      //   mini: true,
      //   onPressed: () {
      //
      //   },
      //   child: SvgPicture.asset('assets/icons/ic_add_wallet.svg'),
      // ),
      //
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
      //   child: ExpandedButton(
      //       child: const Text('Перевести все', style: TextStyle(color: Colors.white),),
      //       onPressed: (){}
      //   ),
      // ),

    );
  }
}




class CurrentBalance extends StatefulWidget {
  const CurrentBalance({super.key, required this.textWidget, required this.contractId, required this.contractServiceId, required this.navigationPageCubit});

  final Text textWidget;
  final int contractId;
  final int contractServiceId;
  final NavigationPageCubit navigationPageCubit;

  @override
  State<CurrentBalance> createState() => _CurrentBalanceState();
}

class _CurrentBalanceState extends State<CurrentBalance> with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _controller;

  String? updatedBalance;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> makeBalanceUpdate() async {
    setState(() {
      _isLoading = true;
    });
    _controller.repeat();

    try{
      Contract? contractData = await ContractRepository.updateBalance(context, widget.contractId, widget.contractServiceId);

      if(contractData!= null && contractData.clientContractServices!.isNotEmpty){

        ClientContractService? ccs = contractData.clientContractServices![0].content?.firstWhere((element) => element.id == widget.contractServiceId);

        if(ccs!= null){
          setState(() {
            updatedBalance = AppFormatter().formatCurrency(
                ccs.balance!,
                ccs.currency?.code != null ? CurrencySymbol.getCurrencySymbol(ccs.currency!.code!): '',
                0
            );
          });
        }
      }
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        widget.navigationPageCubit.showMessage(exception.message, false);
      }else{
        rethrow;
      }
    } finally{
      setState(() {
        _isLoading = false;
      });
      _controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await makeBalanceUpdate();
      },
      child: Row(
        children: [
          RotationTransition(
            turns: _isLoading ? _controller : const AlwaysStoppedAnimation(0),
            child: SvgPicture.asset('assets/icons/ic_reset.svg'),
          ),
          const SizedBox(width: 5),
          Text(
            'Остаток на счете',
            style: TextStyle(color: AppColors.mainGrey, fontSize: 12),
          ),
          const SizedBox(width: 5),
          updatedBalance != null ? Text(updatedBalance ?? '',style: const TextStyle(fontSize: 12),) : widget.textWidget,
        ],
      ),
    );
  }
}


