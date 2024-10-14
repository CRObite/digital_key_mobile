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