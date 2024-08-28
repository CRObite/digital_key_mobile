import 'package:web_com/domain/client.dart';

import 'dio_helper.dart';

class ClientRepository{

  static Future<Client?> getClient(String url) async {

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(url, true, null, null, RequestTypeEnum.get);

    if(data!= null){
      Client client =  Client.fromJson(data['content']);

      return client;
    }else {
      return null;
    }

  }
}