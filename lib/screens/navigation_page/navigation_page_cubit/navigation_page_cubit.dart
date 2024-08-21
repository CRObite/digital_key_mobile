

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

}
