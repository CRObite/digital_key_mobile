import 'package:flutter/cupertino.dart';

import 'bank.dart';

class ContactsCardInfo{
  int? id;
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController emailController;
  bool contactPerson;

  ContactsCardInfo(this.nameController, this.phoneController,
      this.emailController, this.contactPerson, {this.id});
}

class BankCardInfo{
  List<String> listOfBank;
  String selected;
  TextEditingController bankAccount;
  bool mainAccount;
  List<String> listOfCurrency;
  int currencySelected;

  BankCardInfo(this.listOfBank, this.selected, this.bankAccount,
      this.mainAccount, this.listOfCurrency, this.currencySelected);
}

