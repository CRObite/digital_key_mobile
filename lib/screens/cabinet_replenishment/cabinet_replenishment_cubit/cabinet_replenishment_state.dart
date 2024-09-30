part of 'cabinet_replenishment_cubit.dart';

@immutable
abstract class CabinetReplenishmentState {}

class CabinetReplenishmentInitial extends CabinetReplenishmentState {}

class CabinetReplenishmentLoading extends CabinetReplenishmentState {}

class CabinetReplenishmentSuccess extends CabinetReplenishmentState {}

class CabinetReplenishmentFirstStep extends CabinetReplenishmentState {}

class CabinetReplenishmentSecondStep extends CabinetReplenishmentState {}

class CabinetReplenishmentThirdStep extends CabinetReplenishmentState {}

class CabinetReplenishmentError extends CabinetReplenishmentState {
  final String errorMessage;

  CabinetReplenishmentError({required this.errorMessage});
}
