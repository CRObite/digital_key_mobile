

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/client_repository.dart';
import '../../../../data/repository/service_repository.dart';
import '../../../../domain/client.dart';
import '../../../../domain/pageable.dart';
import '../../../../domain/service_operation.dart';
import '../../../../utils/custom_exeption.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

part 'cabinet_details_state.dart';

class CabinetDetailsCubit extends Cubit<CabinetDetailsState> {
  CabinetDetailsCubit() : super(CabinetDetailsInitial());

  int page = 0;
  int size = 10;
  int maxPage = 0;

  //operation part


  List<ServiceOperation> operations = [];
  int? clientId;

  Future<void> getCabinetOperations(BuildContext context, NavigationPageCubit navigationPageCubit, int? cabinetId,{needLoading=false}) async {

    if(needLoading){
      emit(CabinetDetailsLoading());
    }

    try{

      if(clientId == null){
        Client? data = await ClientRepository.getClient(context);

        if(data!=  null){
          clientId = data.id;
        }
      }

      Pageable? pageable = await ServiceRepository().getAllOperations(context, page, size, '', clientId, null,cabinetId: cabinetId,);
      if(pageable!= null){
        maxPage = pageable.totalPages;
        for(var item in pageable.content){
          operations.add(ServiceOperation.fromJson(item));
        }
      }

      emit(CabinetDetailsFetched(listOfOperation: operations));

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);
      }else{
        rethrow;
      }
    }
  }



  void resetOperationList(BuildContext context, NavigationPageCubit navigationPageCubit, int? cabinetId) {
    page = 0;
    operations.clear();
    getCabinetOperations(context,navigationPageCubit,cabinetId,needLoading: true);
  }



}
