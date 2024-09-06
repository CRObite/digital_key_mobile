enum AddressType{
  LEGAL, PHYSICAL,
}


AddressType? closingFormFromJson(String? status) {
  if(status == null){
    return null;
  }
  return AddressType.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? closingFormToJson(AddressType? status) {
  return status?.toString().split('.').last;
}
