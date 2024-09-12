enum OrganizationType{
  LLP, LLC, PLC, PC, IE
}

OrganizationType? organizationTypeFromJson(String? status) {
  return status == null? null : OrganizationType.values.firstWhere((e) => e.toString().split('.').last == status);
}


String? organizationTypeToJson(OrganizationType? status) {
  return status?.toString().split('.').last;
}