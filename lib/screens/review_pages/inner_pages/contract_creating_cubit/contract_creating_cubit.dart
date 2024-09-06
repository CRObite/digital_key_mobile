

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contract_creating_state.dart';

class ContractCreatingCubit extends Cubit<ContractCreatingState> {
  ContractCreatingCubit() : super(ContractCreatingInitial());



}
