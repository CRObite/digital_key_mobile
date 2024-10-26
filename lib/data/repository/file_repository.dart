import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_com/domain/attachment.dart';

import '../../config/app_endpoints.dart';
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

  static Future<Uint8List?> getFile(BuildContext context,int fileId) async {

    String url = '${AppEndpoints.getFile}$fileId';

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get, responseType: ResponseType.bytes);

    if(data!= null){
      Uint8List bytes = Uint8List.fromList(data['bytes']);
      return bytes;
    }else {
      return null;
    }
  }

  static Future<String> pickImageFile() async {
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


  static Future<String> pickFile() async {
    print('picker');

    FilePickerResult? result = await FilePicker.platform.pickFiles(
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


  static Future<Attachment?> uploadFile(BuildContext context,String filePath,) async {

    String url = AppEndpoints.createFiles;

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


  static Future<bool> updateFile(BuildContext context,int fileId, String filePath) async {

    String url = '${AppEndpoints.updateFiles}$fileId';

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

  Future<Attachment?> downloadFile(BuildContext context, String url, bool signed) async {

    var param = {
      "signed": signed
    };

    Map<String, dynamic>? data = await DioHelper()
        .makeRequest(context,url, true, RequestTypeEnum.get, parameters: param);

    if(data!= null){
      return Attachment.fromJson(data);
    }
    return null;
  }

  Future<bool> downloadUint8List(String filename, Uint8List bytes) async {
    final directory = await getTemporaryDirectory();

    final filePath = '${directory.path}/$filename';
    final file = File(filePath);

    await file.writeAsBytes(bytes);

    final params = SaveFileDialogParams(
      sourceFilePath: file.path,
      fileName: filename,
    );

    final result = await FlutterFileDialog.saveFile(params: params);

    if (result != null) {
      print('File saved at $result');
      return true;
    } else {
      print('File save canceled');
      return false;
    }
  }
}