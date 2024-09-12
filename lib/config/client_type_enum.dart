enum ClientType{
  BUSINESS, INDIVIDUAL
}

ClientType? clientTypeFromJson(String? status) {
  return status == null? null:ClientType.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? clientTypeToJson(ClientType? status) {
  return status?.toString().split('.').last;
}
