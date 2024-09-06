enum ClosingForm{
  ESF,
  PAPER,
}


ClosingForm? closingFormFromJson(String? status) {
  if(status == null){
    return null;
  }
  return ClosingForm.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? closingFormToJson(ClosingForm? status) {
  return status?.toString().split('.').last;
}

extension StatusExtension on ClosingForm {
  String get description {
    switch (this) {
      case ClosingForm.ESF:
        return "Активен";
      case ClosingForm.PAPER:
        return "Прекращен";
      default:
        return "Неизвестный статус";
    }
  }
}