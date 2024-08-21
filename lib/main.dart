import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_com/screens/application.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);



  runApp(const Application());
}

