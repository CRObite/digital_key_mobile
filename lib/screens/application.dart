import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_com/screens/review_pages/review_page.dart';
import 'package:web_com/screens/navigation_page/navigation_page.dart';
import 'package:web_com/utils/scale_size.dart';
import 'package:web_com/utils/scroll_behavior.dart';

import '../config/app_navigation.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'DigitalKey',
      routerConfig: AppNavigation.router,
      theme: ThemeData(
        textTheme: GoogleFonts.onestTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: Colors.white
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          ),
          child: child!
        );
      },

    );
  }
}
