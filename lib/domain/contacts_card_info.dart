import 'package:flutter/cupertino.dart';

class ContactsCardInfo{
  int? id;
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController emailController;
  bool contactPerson;

  ContactsCardInfo(this.id, this.nameController, this.phoneController,
      this.emailController, this.contactPerson);
}