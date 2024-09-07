

enum SignerType{
  CHARTER, ORDER, COUPON, ATTORNEY
}


SignerType? closingFormFromJson(String? status) {
  if(status == null){
    return null;
  }
  return SignerType.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? closingFormToJson(SignerType? status) {
  return status?.toString().split('.').last;
}

List<String> getSignerTypeDescriptions() {
  return SignerType.values.map((e) => e.description).toList();
}

extension StatusExtension on SignerType {
  String get description {
    switch (this) {
      case SignerType.CHARTER:
        return "Устав";
      case SignerType.ORDER:
        return "Приказ";
      case SignerType.COUPON:
        return "Талон";
      case SignerType.ATTORNEY:
        return "Доверенность";
      default:
        return "Неизвестный статус";
    }
  }
}