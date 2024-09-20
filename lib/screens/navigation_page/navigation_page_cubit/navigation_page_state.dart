part of 'navigation_page_cubit.dart';

@immutable
abstract class NavigationPageState {}

class NavigationPageInitial extends NavigationPageState {}

class NavigationPageOpened extends NavigationPageState {}

class NavigationPageClosed extends NavigationPageState {}

class NavigationPageChanger extends NavigationPageState {}

class NavigationPageMessage extends NavigationPageState {
  final String message;
  final bool positive;

  NavigationPageMessage( {required this.positive,required this.message});
}

