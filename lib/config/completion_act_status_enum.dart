
enum CompletionActStatus {
  NEW,
  AVAILABLE,
  NOT_AVAILABLE,
  DELETION,
  ERROR,
  SKIP,
  OVERDUE_DEBT
}

CompletionActStatus? completionActStatusFromJson(String? status) {
  return status == null
      ? null
      : CompletionActStatus.values
          .firstWhere((e) => e.toString().split('.').last == status);
}

String? completionActStatusToJson(CompletionActStatus? status) {
  return status?.toString().split('.').last;
}

extension CompletionActStatusExtension on CompletionActStatus {
  String get description {
    switch (this) {
      case CompletionActStatus.NEW:
        return "Новый";
      case CompletionActStatus.AVAILABLE:
        return "Доступен";
      case CompletionActStatus.NOT_AVAILABLE:
        return "Недоступен";
      case CompletionActStatus.DELETION:
        return "На удаление";
      case CompletionActStatus.ERROR:
        return "Ошибка";
      case CompletionActStatus.SKIP:
        return "Пропущен";
      case CompletionActStatus.OVERDUE_DEBT:
        return "Просроченная";
      default:
        return "Неизвестный статус";
    }
  }
}

List<String> getCompletionActStatusDescriptions() {
  return CompletionActStatus.values
      .map((status) => status.description)
      .toList();
}

CompletionActStatus? getCompletionActStatusByDescription(String? description) {
  for (var status in CompletionActStatus.values) {
    if (status.description == description) {
      return status;
    }
  }
  return null;
}

