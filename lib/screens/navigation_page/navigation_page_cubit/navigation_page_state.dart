part of 'navigation_page_cubit.dart';

@immutable
abstract class NavigationPageState {}

class NavigationPageInitial extends NavigationPageState {}

class NavigationPageOpened extends NavigationPageState {}

class NavigationPageClosed extends NavigationPageState {}

class NavigationPageMessage extends NavigationPageState {
  final String message;

  NavigationPageMessage({required this.message});
}

