

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_endpoints.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/currency_repository.dart';
import '../../../domain/currency_rates.dart';
import '../../../domain/user.dart';

part 'side_bar_state.dart';

class SideBarCubit extends Cubit<SideBarState> {
  SideBarCubit() : super(SideBarInitial());

  Future<void> getSideBarData(BuildContext context) async {

    emit(SideBarLoading());

    try{
      String url = '${AppEndpoints.address}${AppEndpoints.getMe}';

      User? user =  await AuthRepository.getMe(context,url);

      url = '${AppEndpoints.address}${AppEndpoints.getMostRecentCurrencies}';

      List<CurrencyRates> value =  await CurrencyRepository.getMostRecent(context, url);

      emit(SideBarSuccess(listOfCurrency: value, user: user!));

    }catch(e){
      rethrow;
    }

  }
}
