enum ClosingForm{
  ESF,
  PAPER,
}


ClosingForm? closingFormFromJson(String? status) {
  return status == null? null : ClosingForm.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? closingFormToJson(ClosingForm? status) {
  return status?.toString().split('.').last;
}

List<String> getClosingFormDescriptions() {
  return ClosingForm.values.map((e) => e.description).toList();
}

extension StatusExtension on ClosingForm {
  String get description {
    switch (this) {
      case ClosingForm.ESF:
        return "На носители";
      case ClosingForm.PAPER:
        return "На бумаге";
      default:
        return "Неизвестный статус";
    }
  }
}