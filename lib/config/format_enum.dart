enum Format{
  RA, SU, NV, INDIVIDUAL, PARTNER
}

Format? formatFromJson(String? status) {
  return status == null? null : Format.values.firstWhere((e) => e.toString().split('.').last == status);
}


String? formatToJson(Format? status) {
  return status?.toString().split('.').last;
}