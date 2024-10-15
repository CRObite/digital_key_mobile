import 'package:flutter/cupertino.dart';

import '../../config/app_endpoints.dart';
import '../../domain/pageable.dart';
import 'dio_helper.dart';

class TransactionsRepository{
  Future<Pageable?> getTransactions(BuildContext context,int page,int size,int clientId) async {

    String url = AppEndpoints.getAllTransactions;

    var param = {
      "page": page,
      "size": size,
      "clientId": clientId,
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get,parameters: param,accessiblePage: 'FinancePaymentDetail');

    if(data!= null){
      return Pageable.fromJson(data);
    }else {
      return null;
    }
  }
}