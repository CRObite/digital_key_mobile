enum ClientType{
  BUSINESS, INDIVIDUAL
}

ClientType? clientTypeFromJson(String? status) {
  if(status == null){
    return null;
  }
  return ClientType.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? clientTypeToJson(ClientType? status) {
  return status?.toString().split('.').last;
}
