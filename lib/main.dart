import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_com/config/app_navigation.dart';
import 'package:web_com/screens/application.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  AppNavigation.checkCurrentUser();

  runApp(const Application());
}

