enum SalesState{
  OP, NP, DP
}

SalesState? salesStateFromJson(String? status) {
  return status == null? null : SalesState.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? salesStateToJson(SalesState? status) {
  return status?.toString().split('.').last;
}