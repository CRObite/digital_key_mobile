enum ServiceOperationPayform{
  PRE_PAYMENT, POST_PAYMENT, MIXED
}

ServiceOperationPayform? serviceOperationPayFormFromJson(String? status) {
  if(status == null){
    return null;
  }
  return ServiceOperationPayform.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? serviceOperationPayFormToJson(ServiceOperationPayform? status) {
  return status?.toString().split('.').last;
}