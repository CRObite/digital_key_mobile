enum ElectronicInvoiceType{
  USUAL, CORRECTED, ADDITIONAL
}

ElectronicInvoiceType? electronicInvoiceTypeFromJson(String? status) {
  return status == null? null : ElectronicInvoiceType.values.firstWhere((e) => e.toString().split('.').last == status);
}


String? electronicInvoiceTypeToJson(ElectronicInvoiceType? status) {
  return status?.toString().split('.').last;
}