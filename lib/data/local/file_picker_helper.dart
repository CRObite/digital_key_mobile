import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FilePickerHelper{
  static Future<File?> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.name);

      return file;
    } else {
      return null;
    }
  }
}