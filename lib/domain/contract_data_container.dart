import 'package:flutter/cupertino.dart';

class ContractDataContainer{
  String icon;
  String name;
  List<ContainerComponent> components;

  ContractDataContainer(this.icon, this.name, this.components);
}

class ContainerComponent{
  ContainerType type;
  String name;
  TextEditingController? controller;
  List<dynamic>? dropdownElements;
  dynamic selectedValue;
  TextInputType? filedType;
  String? errorText;
  bool checkBoxValue;
  bool filePicked;
  bool important;

  ContainerComponent(this.type, this.name, {this.selectedValue, this.controller,
    this.dropdownElements, this.filedType, this.errorText, this.important = false, this.checkBoxValue= false, this.filePicked = false});
}

enum ContainerType{
  textField,
  checkBox,
  dropDown,
  filePicker
}
