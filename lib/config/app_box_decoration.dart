import 'package:flutter/material.dart';

import 'app_shadow.dart';

class AppBoxDecoration{
  static BoxDecoration boxWithShadow = BoxDecoration(
    color: Colors.white,
    boxShadow: AppShadow.shadow,
    borderRadius: const BorderRadius.all(Radius.circular(12))
  );
}