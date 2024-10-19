
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/data/repository/contract_repository.dart';
import 'package:web_com/data/repository/service_repository.dart';
import 'package:web_com/domain/pageable.dart';
import 'package:web_com/screens/navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import 'package:web_com/utils/custom_exeption.dart';

import '../../../../domain/client_contract_service.dart';

part 'review_office_state.dart';

class ReviewOfficeCubit extends Cubit<ReviewOfficeState> {
  ReviewOfficeCubit() : super(ReviewOfficeInitial());

  int page = 0;
  int size = 10;
  int maxPage = 0;
  List<ClientContractService> listOfCCS = [];

  Future<void> getCabinetData(BuildContext context, String query, NavigationPageCubit navigationPageCubit, {needLoading=false}) async {

    if(needLoading){
      emit(ReviewOfficeLoading());
    }

    try{
      Pageable? pageable = await ContractRepository.getContractService(context, query, page, size);

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


  void resetList(BuildContext context, String query, NavigationPageCubit navigationPageCubit,) {
    page = 0;
    listOfCCS.clear();
    getCabinetData(context,query, navigationPageCubit, needLoading: true);
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

  Future<void> getCabinetOperations(BuildContext context, NavigationPageCubit navigationPageCubit, {needLoading=false}) async {

    if(needLoading){
      emit(ReviewOfficeLoading());
    }

    try{
      Pageable? pageable = await ServiceRepository().getAllOperations(context, page, size);

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
      }else{
        rethrow;
      }
    }
  }


}
