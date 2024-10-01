enum ElectronicInvoiceDirection{
  IN, OUT
}

ElectronicInvoiceDirection? electronicInvoiceDirectionFromJson(String? status) {
  return status == null? null : ElectronicInvoiceDirection.values.firstWhere((e) => e.toString().split('.').last == status);
}


String? electronicInvoiceDirectionToJson(ElectronicInvoiceDirection? status) {
  return status?.toString().split('.').last;
}