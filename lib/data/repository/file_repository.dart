import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'dio_helper.dart';

class FileRepository{
  static Future<Uint8List?> getImageFile(BuildContext context,String url, int imageId) async {


    final cacheManager = DefaultCacheManager();
    final fileInfo = await cacheManager.getFileFromCache('$imageId');

    if (fileInfo != null) {
      return fileInfo.file.readAsBytes();
    } else {
      Map<String, dynamic>? data = await DioHelper()
          .makeRequest(context,url, true, null, null, RequestTypeEnum.get, responseType: ResponseType.bytes);

      if(data!= null){
        Uint8List bytes = Uint8List.fromList(data['bytes']);
        await cacheManager.putFile('$imageId', bytes);
        return bytes;
      }else {
        return null;
      }
    }

  }
}