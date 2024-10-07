import 'package:flutter/material.dart';

import '../../config/app_endpoints.dart';
import '../../domain/position.dart';
import 'dio_helper.dart';

class PositionRepository{
  Future<List<Position>> getPositions(BuildContext context) async {

    String url = AppEndpoints.getAllPosition;

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get);

    if(data!= null){

      List<Position> positions = [];

      for(var item in data['list']){
        positions.add(Position.fromJson(item));
      }

      return positions;
    }else {
      return [];
    }
  }
}