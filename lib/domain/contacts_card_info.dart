import 'package:flutter/cupertino.dart';
import 'package:web_com/domain/currency.dart';

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
  int? id;
  Bank? selected;
  TextEditingController bankAccount;
  bool mainAccount;
  List<Currency> listOfCurrency;
  Currency? currencySelected;

  BankCardInfo(this.id,this.selected, this.bankAccount,
      this.mainAccount, this.listOfCurrency, this.currencySelected);
}

