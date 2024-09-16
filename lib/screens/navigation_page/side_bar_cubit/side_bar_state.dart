part of 'side_bar_cubit.dart';

@immutable
abstract class SideBarState {}

class SideBarInitial extends SideBarState {}

class SideBarSuccess extends SideBarState {
  final User user;
  final List<CurrencyRates> listOfCurrency;

  SideBarSuccess({required this.user, required this.listOfCurrency});
}

class SideBarLoading extends SideBarState {}