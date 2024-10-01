enum InvoiceType{
  BUDGET, PENALTY, INDEXING, DEVELOPMENT, AD_CABINET, OTHER
}

InvoiceType? invoiceTypeFromJson(String? status) {
  return status == null? null : InvoiceType.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? invoiceTypeToJson(InvoiceType? status) {
  return status?.toString().split('.').last;
}