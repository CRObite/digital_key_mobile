enum ClientCondition{
  STANDARD, SPECIAL
}

ClientCondition? clientConditionFromJson(String? status) {
  return status == null? null : ClientCondition.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? clientConditionToJson(ClientCondition? status) {
  return status?.toString().split('.').last;
}