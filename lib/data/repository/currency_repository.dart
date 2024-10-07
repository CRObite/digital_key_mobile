import 'package:flutter/cupertino.dart';
import 'package:web_com/domain/currency_rates.dart';

import '../../config/app_endpoints.dart';
import '../../domain/currency.dart';
import 'dio_helper.dart';

class CurrencyRepository{
  static Future<List<CurrencyRates>> getMostRecent(BuildContext context) async {

    String url = AppEndpoints.getMostRecentCurrencies;

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get,);

    if(data!= null){

      List<dynamic> values = data['rates'];
      List<CurrencyRates> listOfCurrency = [];

      for(var item in values){
        listOfCurrency.add(CurrencyRates.fromJson(item));
      }

      return listOfCurrency;
    }else {
      return [];
    }
  }

  static Future<List<Currency>> getAllCurrencies(BuildContext context) async {

    String url = AppEndpoints.getAllCurrencies;

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get,);

    if(data!= null){

      List<dynamic> values = data['list'];
      List<Currency> listOfCurrency = [];

      for(var item in values){
        listOfCurrency.add(Currency.fromJson(item));
      }

      return listOfCurrency;
    }else {
      return [];
    }

  }
}