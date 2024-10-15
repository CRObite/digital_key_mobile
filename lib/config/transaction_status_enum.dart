enum TransactionStatus{
  NEW, PROCESSED, DELETION, SKIP, ERROR
}

TransactionStatus? transactionStatusFromJson(String? status) {
  if(status == null){
    return null;
  }
  return TransactionStatus.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? transactionStatusToJson(TransactionStatus? status) {
  return status?.toString().split('.').last;
}

extension TransactionStatusExtension on TransactionStatus {
  String get description {
    switch (this) {
      case TransactionStatus.NEW:
        return "Новый";
      case TransactionStatus.PROCESSED:
        return "Обработанный";
      case TransactionStatus.DELETION:
        return "На удаление";
      case TransactionStatus.SKIP:
        return "Пропущенный";
      case TransactionStatus.ERROR:
        return "Ошибка";
      default:
        return "Неизвестный статус";
    }
  }
}
