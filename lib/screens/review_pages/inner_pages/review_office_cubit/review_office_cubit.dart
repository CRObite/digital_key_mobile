
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/data/repository/client_repository.dart';
import 'package:web_com/data/repository/contract_repository.dart';
import 'package:web_com/data/repository/service_repository.dart';
import 'package:web_com/domain/pageable.dart';
import 'package:web_com/domain/service_operation.dart';
import 'package:web_com/screens/navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import 'package:web_com/utils/custom_exeption.dart';

import '../../../../domain/client.dart';
import '../../../../domain/client_contract_service.dart';

part 'review_office_state.dart';

class ReviewOfficeCubit extends Cubit<ReviewOfficeState> {
  ReviewOfficeCubit() : super(ReviewOfficeInitial());

  int page = 0;
  int size = 10;
  int maxPage = 0;
  List<ClientContractService> listOfCCS = [];

  Future<void> getCabinetData(BuildContext context, String? query, NavigationPageCubit navigationPageCubit,int? serviceId,{needLoading=false}) async {

    if(needLoading){
      emit(ReviewOfficeLoading());
    }

    try{
      Pageable? pageable = await ContractRepository.getContractService(context, query, page, size, serviceId: serviceId);

      if(pageable!= null){
        for(var item in pageable.content){
          listOfCCS.add(ClientContractService.fromJson(item));
        }

        maxPage = pageable.totalPages;
        setScroller(listOfCCS.length);
        emit(ReviewOfficeSuccess(listOfCCS: listOfCCS));
      }
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
      }else{
        rethrow;
      }
    }
  }


  void resetList(BuildContext context, String? query, NavigationPageCubit navigationPageCubit,int? serviceId) {
    page = 0;
    listOfCCS.clear();
    getCabinetData(context,query, navigationPageCubit,serviceId, needLoading: true);
  }



  List<ScrollController> scrollControllers = [];

  void setScroller(int count){
    for (int i = 0; i < count; i++) {
      final controller = ScrollController();
      controller.addListener(() => _syncScroll(controller));
      scrollControllers.add(controller);
    }
  }

  void _syncScroll(ScrollController scrolledController) {
    final scrollOffset = scrolledController.hasClients
        ? scrolledController.offset
        : 0.0;

    for (final controller in scrollControllers) {
      if (controller != scrolledController && controller.hasClients && controller.offset != scrollOffset) {
        controller.jumpTo(scrollOffset);
      }
    }
  }



  //operation part


  List<ServiceOperation> operations = [];
  int? clientId;

  Future<void> getCabinetOperations(BuildContext context, NavigationPageCubit navigationPageCubit, String? status ,String? query ,String? type ,{needLoading=false}) async {

    if(needLoading){
      emit(ReviewOfficeLoading());
    }

    try{

      if(clientId == null){
        Client? data = await ClientRepository.getClient(context);

        if(data!=  null){
          clientId = data.id;
        }
      }

      Pageable? pageable = await ServiceRepository().getAllOperations(context, page, size, status ?? '', clientId, type, query: query,);
      if(pageable!= null){
        maxPage = pageable.totalPages;
        for(var item in pageable.content){
           operations.add(ServiceOperation.fromJson(item));
        }
      }

      emit(ReviewOfficeOperationSuccess(listOfOperations: operations));

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
      }else{
        rethrow;
      }
    }
  }



  void resetOperationList(BuildContext context, NavigationPageCubit navigationPageCubit,String? status,String? type,String? query) {
    page = 0;
    operations.clear();
    getCabinetOperations(context,navigationPageCubit, status,query,type,needLoading: true);
  }

}
