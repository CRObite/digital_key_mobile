import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_com/config/app_shadow.dart';

import '../config/app_colors.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key, required this.title, this.errorText, this.important = false, required this.dropDownList, required this.onSelected, this.withoutTitle = false, this.withShadow = false, this.hint = '', this.selectedItem});

  final String title;
  final String hint;
  final String? errorText;
  final bool important;
  final List<dynamic> dropDownList;
  final Function(dynamic) onSelected;
  final bool withoutTitle;
  final bool withShadow;
  final dynamic selectedItem;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {



  @override
  void initState() {
    _selectedItem = widget.selectedItem;
    super.initState();
  }



  dynamic _selectedItem;
  bool _opened = false;


  @override
  void didUpdateWidget(covariant CustomDropDown oldWidget) {
    if(widget.selectedItem != _selectedItem){
      setState(() {
        _selectedItem = widget.selectedItem;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.withoutTitle ? const SizedBox() : RichText(
          text: TextSpan(
            text: widget.title,
            style: const TextStyle(fontSize: 12, color: Colors.black),
            children: widget.important ? [
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ] : [],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              border: widget.withShadow ? null : Border.all(
                color: AppColors.borderGrey,
              ),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: widget.withShadow ? AppShadow.shadow : null
          ),
          child: DropdownButtonHideUnderline(

            child: DropdownButton2<dynamic>(

              isExpanded: true,
              onMenuStateChange: (isOpen) {
                setState(() {
                  _opened = !_opened;
                });
              },
              hint: Text(
               widget.hint.isNotEmpty? widget.hint : widget.title,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.mainGrey,
                ),
              ),

              items: widget.dropDownList
                  .map((dynamic item) => DropdownMenuItem<dynamic>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ))
                  .toList(),
              value: _selectedItem,
              onChanged: (dynamic value) {
                setState(() {
                  _selectedItem = value;
                });

                widget.onSelected(value);
              },
              iconStyleData:  IconStyleData(
                icon: Icon(
                  _opened ?Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                ),
                iconSize: 25,
                iconDisabledColor: AppColors.mainGrey,
                iconEnabledColor: AppColors.mainGrey,
              ),
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
              ),
              dropdownStyleData: DropdownStyleData(
                elevation: 1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                maxHeight: 200,
                offset: const Offset(0, -10),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 50,
              ),
            ),
          ),
        ),

        if(widget.errorText != null)
          Column(
            children: [
              const SizedBox(height: 10,),
              Text(widget.errorText!,style: const TextStyle(fontSize: 12, color: Colors.red),),
            ],
          ),
      ],
    );
  }
}
