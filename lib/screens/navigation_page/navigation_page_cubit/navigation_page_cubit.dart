

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/data/repository/auth_repository.dart';
import 'package:web_com/data/repository/currency_repository.dart';
import 'package:web_com/domain/currency_rates.dart';

import '../../../config/app_endpoints.dart';
import '../../../domain/user.dart';
import '../../../utils/custom_exeption.dart';

part 'navigation_page_state.dart';

class NavigationPageCubit extends Cubit<NavigationPageState> {
  NavigationPageCubit() : super(NavigationPageInitial());

  void openDrawer() {
    emit(NavigationPageOpened());
  }

  void closeDrawer() {
    emit(NavigationPageClosed());
  }

  void goToBranch( StatefulNavigationShell navigationShell, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  void showMessage(String message, bool positive) {
    emit(NavigationPageMessage(message: message, positive: positive));
  }

}
