

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_com/config/app_navigation.dart';
import 'package:web_com/screens/application.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await AppNavigation.changePathByStatus();

  runApp(const Application());
}
