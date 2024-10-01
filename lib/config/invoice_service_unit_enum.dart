enum InvoiceServiceUnit{
  PERCENT, SERVICE, HOUR, UNIT
}

InvoiceServiceUnit? invoiceServiceUnitFromJson(String? status) {
  return status == null? null : InvoiceServiceUnit.values.firstWhere((e) => e.toString().split('.').last == status);
}


String? invoiceServiceUnitTypeToJson(InvoiceServiceUnit? status) {
  return status?.toString().split('.').last;
}