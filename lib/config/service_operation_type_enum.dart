enum ServiceOperationType{
  TRANSFER, REFUND, FUND
}

ServiceOperationType? serviceOperationTypeFromJson(String? status) {
  if(status == null){
    return null;
  }
  return ServiceOperationType.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? serviceOperationTypeToJson(ServiceOperationType? status) {
  return status?.toString().split('.').last;
}

extension ServiceOperationTypeExtension on ServiceOperationType {
  String get description {
    switch (this) {
      case ServiceOperationType.TRANSFER:
        return "Перевод";
      case ServiceOperationType.REFUND:
        return "Списание";
      case ServiceOperationType.FUND:
        return "Пополнение";
      default:
        return "Неизвестный тип операции";
    }
  }
}


ServiceOperationType? serviceOperationTypeFromDescription(String? description) {
  return ServiceOperationType.values.firstWhere(
        (e) => e.description == description,
  );
}