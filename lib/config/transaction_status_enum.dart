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
