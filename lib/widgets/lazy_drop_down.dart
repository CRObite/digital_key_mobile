import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class LazyDropDown extends StatefulWidget {
  const LazyDropDown({super.key});

  @override
  State<LazyDropDown> createState() => _LazyDropDownState();
}

class _LazyDropDownState extends State<LazyDropDown> {
  // State variables
  bool isDropdownOpen = false;
  String selectedValue = 'Select an option';
  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3'];

  // Toggle dropdown state
  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  // Handle item selection
  void selectItem(String value) {
    setState(() {
      selectedValue = value;
      isDropdownOpen = false;  // Close the dropdown after selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown button
        GestureDetector(
          onTap: toggleDropdown,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.borderGrey,
                ),
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedValue),
                Icon(isDropdownOpen
                    ?Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,),
              ],
            ),
          ),
        ),
        // Dropdown items
        if (isDropdownOpen)
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Material(
              elevation: 3,
              child: Container(
                margin: const EdgeInsets.only(top: 4),
                width: double.infinity, // Expands to full width
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.borderGrey,
                  ),
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Column(
                  children: dropdownItems.map((item) {
                    return GestureDetector(
                      onTap: () => selectItem(item),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                        ), // Expanded width
                        child: Text(item),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
