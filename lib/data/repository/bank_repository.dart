import 'package:flutter/cupertino.dart';
import 'package:web_com/domain/pageable.dart';

import '../../config/app_endpoints.dart';
import 'dio_helper.dart';

class BankRepository{
  Future<Pageable?> getBanks(BuildContext context, int page, int size) async {
    var param = {
      'pageable': {
        "page": page,
        "size": size,
      }
    };

    String url = AppEndpoints.getBanks;

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get, parameters: param);

    if(data!= null){
      return Pageable.fromJson(data);
    }else {
      return null;
    }
  }
}