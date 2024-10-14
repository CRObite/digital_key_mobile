enum ServiceOperationStatus{
  NEW, FINISHED, MANUALLY_EXECUTED, FORBIDDEN, ON_CONFIRMATION, DELETION, ERROR
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