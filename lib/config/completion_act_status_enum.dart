enum CompletionActStatus{
  NEW, AVAILABLE, NOT_AVAILABLE, DELETION, ERROR, SKIP, OVERDUE_DEBT
}

CompletionActStatus? completionActStatusFromJson(String? status) {
  return status == null? null : CompletionActStatus.values.firstWhere((e) => e.toString().split('.').last == status);
}


String? completionActStatusToJson(CompletionActStatus? status) {
  return status?.toString().split('.').last;
}