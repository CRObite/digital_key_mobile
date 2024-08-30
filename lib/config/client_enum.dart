enum ClientStatus {
  ACTIVE,
  TERMINATED,
  STOPPED,
  DELETION,
  NEW,
  DRAFT,
}

ClientStatus statusFromJson(String status) {
  return ClientStatus.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? statusToJson(ClientStatus? status) {
  return status?.toString().split('.').last;
}

extension StatusExtension on ClientStatus {
  String get description {
    switch (this) {
      case ClientStatus.ACTIVE:
        return "Активен";
      case ClientStatus.TERMINATED:
        return "Прекращен";
      case ClientStatus.STOPPED:
        return "Остановлен";
      case ClientStatus.DELETION:
        return "Удаление";
      case ClientStatus.NEW:
        return "Новый";
      case ClientStatus.DRAFT:
        return "Черновик";
      default:
        return "Неизвестный статус";
    }
  }
}