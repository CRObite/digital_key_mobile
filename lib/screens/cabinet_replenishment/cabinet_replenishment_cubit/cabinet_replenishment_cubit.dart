
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cabinet_replenishment_state.dart';

class CabinetReplenishmentCubit extends Cubit<CabinetReplenishmentState> {
  CabinetReplenishmentCubit() : super(CabinetReplenishmentInitial());


}
