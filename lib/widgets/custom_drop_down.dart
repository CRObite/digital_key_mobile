import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_colors.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key, required this.title, this.errorText, required this.important, required this.dropDownList, required this.onSelected});

  final String title;
  final String? errorText;
  final bool important;
  final List<dynamic> dropDownList;
  final Function(dynamic) onSelected;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {


  dynamic _selectedItem;
  bool _opened = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.title,
            style: const TextStyle(fontSize: 12, color: Colors.black), // Base style for the text
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
              border: Border.all(
                color: AppColors.borderGrey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12))
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
                widget.title,
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
                  style: GoogleFonts.poppins(
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
