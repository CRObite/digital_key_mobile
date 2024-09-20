import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_com/domain/attachment.dart';

import 'dio_helper.dart';

class FileRepository{
  static Future<Uint8List?> getImageFile(BuildContext context,String url, int imageId) async {

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get, responseType: ResponseType.bytes);

    if(data!= null){
      Uint8List bytes = Uint8List.fromList(data['bytes']);
      return bytes;
    }else {
      return null;
    }
  }

  static Future<String> pickFile() async {
    print('picker');

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      if(file.path != null){

        print(file.path);
        return file.path!;
      }else{
        return '';
      }
    } else {
      return '';
    }
  }

  static Future<Attachment?> uploadFile(BuildContext context,String url, String filePath,) async {

    String fileName = filePath.split('/').last;

    print(await MultipartFile.fromFile(filePath, filename: fileName));

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
    });

    try{
      Map<String, dynamic>? data = await DioHelper()
          .makeRequest(context,url, true,RequestTypeEnum.post, fileData: formData);

      if(data!= null){
        Attachment attachment = Attachment.fromJson(data);

        return attachment;
      }

    }catch(e){
      return null;
    }

    return null;

  }


  static Future<bool> updateFile(BuildContext context,String url, String filePath) async {

    String fileName = filePath.split('/').last;

    print(fileName);

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
    });

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true,RequestTypeEnum.put, fileData: formData);

    if(data!= null){

      return true;
    }

    return false;

  }

}