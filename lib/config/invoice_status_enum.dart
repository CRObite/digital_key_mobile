enum InvoiceStatus{
  OVERDUE_DEBT, PAYMENT_NOT_APPLIED, NEW, OVERPAYMENT, UNDERPAYMENT, ISSUED, PROCESSING, ERROR, SKIP, DELETION, DRAFT, CLOSED, PAID
}

InvoiceStatus? invoiceStatusFromJson(String? status) {
  return status == null? null : InvoiceStatus.values.firstWhere((e) => e.toString().split('.').last == status);
}


String? invoiceStatusToJson(InvoiceStatus? status) {
  return status?.toString().split('.').last;
}