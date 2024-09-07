enum AddressType{
  LEGAL, PHYSICAL,
}


AddressType? addressTypeFromJson(String? status) {
  if(status == null){
    return null;
  }
  return AddressType.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? addressTypeToJson(AddressType? status) {
  return status?.toString().split('.').last;
}
