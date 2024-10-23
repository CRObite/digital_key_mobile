enum InvoiceStatus{
  OVERDUE_DEBT, PAYMENT_NOT_APPLIED, NEW, OVERPAYMENT, UNDERPAYMENT, ISSUED, PROCESSING, ERROR, SKIP, DELETION, DRAFT, CLOSED, PAID
}

InvoiceStatus? invoiceStatusFromJson(String? status) {
  return status == null? null : InvoiceStatus.values.firstWhere((e) => e.toString().split('.').last == status);
}


String? invoiceStatusToJson(InvoiceStatus? status) {
  return status?.toString().split('.').last;
}


extension InvoiceStatusExtension on InvoiceStatus {
  String get description {
    switch (this) {
      case InvoiceStatus.OVERDUE_DEBT:
        return "Просроченный";
      case InvoiceStatus.PAYMENT_NOT_APPLIED:
        return "Платеж не применен";
      case InvoiceStatus.NEW:
        return "Новый";
      case InvoiceStatus.OVERPAYMENT:
        return "Переплата";
      case InvoiceStatus.UNDERPAYMENT:
        return "Недоплата";
      case InvoiceStatus.ISSUED:
        return "Выставлен";
      case InvoiceStatus.PROCESSING:
        return "Обработка";
      case InvoiceStatus.ERROR:
        return "Ошибка";
      case InvoiceStatus.SKIP:
        return "Пропущенный";
      case InvoiceStatus.DELETION:
        return "На удаление";
      case InvoiceStatus.DRAFT:
        return "Черновик";
      case InvoiceStatus.CLOSED:
        return "Закрыт";
      case InvoiceStatus.PAID:
        return "Оплачен";
      default:
        return "Неизвестный статус";
    }
  }
}

List<String> getInvoiceStatusDescriptions() {
  return InvoiceStatus.values.map((status) => status.description).toList();
}


InvoiceStatus? getInvoiceStatusByDescription(String? description) {
  for (var status in InvoiceStatus.values) {
    if (status.description == description) {
      return status;
    }
  }
  return null;
}