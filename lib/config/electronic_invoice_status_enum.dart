enum ElectronicInvoiceStatus{
  NEW, DELIVERED, ACCEPTED, REVOKED, ERROR, SKIP, DELETION, CANCELLED
}

ElectronicInvoiceStatus? electronicInvoiceStatusFromJson(String? status) {
  return status == null? null : ElectronicInvoiceStatus.values.firstWhere((e) => e.toString().split('.').last == status);
}


String? electronicInvoiceStatusTypeToJson(ElectronicInvoiceStatus? status) {
  return status?.toString().split('.').last;
}