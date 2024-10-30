enum ServiceOperationStatus{
  NEW, FINISHED, MANUALLY_EXECUTED, FORBIDDEN, DELETION, ERROR
}

ServiceOperationStatus? serviceOperationStatusFromJson(String? status) {
  if(status == null){
    return null;
  }
  return ServiceOperationStatus.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? serviceOperationStatusToJson(ServiceOperationStatus? status) {
  return status?.toString().split('.').last;
}

extension ServiceOperationStatusExtension on ServiceOperationStatus {
  String get description {
    switch (this) {
      case ServiceOperationStatus.NEW:
        return "Новый";
      case ServiceOperationStatus.FINISHED:
        return "Завершенный";
      case ServiceOperationStatus.MANUALLY_EXECUTED:
        return "Выполненный вручную";
      case ServiceOperationStatus.FORBIDDEN:
        return "Запрещенный";
      case ServiceOperationStatus.DELETION:
        return "На удаление";
      case ServiceOperationStatus.ERROR:
        return "Ошибка";
      default:
        return "Неизвестный статус";
    }
  }
}

List<String> getServiceOperationStatusDescriptions() {
  return ServiceOperationStatus.values.map((e) => e.description).toList();
}

ServiceOperationStatus? serviceOperationStatusFromDescription(String? description) {
  return ServiceOperationStatus.values.firstWhere(
        (e) => e.description == description,
  );
}