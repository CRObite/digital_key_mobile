part of 'cabinet_details_cubit.dart';

@immutable
abstract class CabinetDetailsState {}

class CabinetDetailsInitial extends CabinetDetailsState {}

class CabinetDetailsLoading extends CabinetDetailsState {}

class CabinetDetailsFetched extends CabinetDetailsState {
  final List<ServiceOperation> listOfOperation;

  CabinetDetailsFetched({required this.listOfOperation});
}
