enum ElectronicInvoiceStatus{
  NEW, DELIVERED, ACCEPTED, REVOKED, ERROR, SKIP, DELETION, CANCELLED
}

ElectronicInvoiceStatus? electronicInvoiceStatusFromJson(String? status) {
  return status == null? null : ElectronicInvoiceStatus.values.firstWhere((e) => e.toString().split('.').last == status);
}


String? electronicInvoiceStatusTypeToJson(ElectronicInvoiceStatus? status) {
  return status?.toString().split('.').last;
}

extension ElectronicInvoiceStatusExtension on ElectronicInvoiceStatus {
  String get description {
    switch (this) {
      case ElectronicInvoiceStatus.NEW:
        return "Новый";
      case ElectronicInvoiceStatus.DELIVERED:
        return "Доставлен";
      case ElectronicInvoiceStatus.ACCEPTED:
        return "Принят";
      case ElectronicInvoiceStatus.REVOKED:
        return "Отозван";
      case ElectronicInvoiceStatus.ERROR:
        return "Ошибка";
      case ElectronicInvoiceStatus.SKIP:
        return "Пропущен";
      case ElectronicInvoiceStatus.DELETION:
        return "На удаление";
      case ElectronicInvoiceStatus.CANCELLED:
        return "Отменен";
      default:
        return "Неизвестный статус";
    }
  }
}

List<String> getElectronicInvoiceStatusDescriptions() {
  return ElectronicInvoiceStatus.values.map((status) => status.description).toList();
}

ElectronicInvoiceStatus? getElectronicInvoiceStatusByDescription(String? description) {
  for (var status in ElectronicInvoiceStatus.values) {
    if (status.description == description) {
      return status;
    }
  }
  return null;
}