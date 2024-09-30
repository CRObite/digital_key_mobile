enum ProviderType{
  GOOGLE, YANDEX, FACEBOOK, TIKTOK, APPLE, DV360, VK, MY_TARGET, HUAWEI, LOCAL
}

ProviderType? providerTypeFromJson(String? status) {
  return status == null? null : ProviderType.values.firstWhere((e) => e.toString().split('.').last == status);
}

String? providerTypeToJson(ProviderType? status) {
  return status?.toString().split('.').last;
}
