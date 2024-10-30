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


extension ServiceOperationPayformExtension on ServiceOperationPayform {
  String get description {
    switch (this) {
      case ServiceOperationPayform.PRE_PAYMENT:
        return "Предоплата";
      case ServiceOperationPayform.POST_PAYMENT:
        return "Постоплата";
      case ServiceOperationPayform.MIXED:
        return "Смешанная оплата";
      default:
        return "Неизвестная форма оплаты";
    }
  }
}