import 'package:web_com/domain/pageable.dart';

import 'dio_helper.dart';

class ContractRepository{

  static Future<Pageable?> getContractsByClientId(String url,int clientId,int page,int size) async {

    Map<String, dynamic> param = {
      "clientId": clientId,
      "page": page,
      "size": size,
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(url, true, param, null, RequestTypeEnum.get);

    if(data!= null){

      Pageable pageable = Pageable.fromJson(data);

      return pageable;
    }else {
      return null;
    }

  }
}