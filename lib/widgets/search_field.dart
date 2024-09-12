import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/app_colors.dart';
import '../config/app_icons.dart';
import '../config/app_texts.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.controller, required this.height, required this.focusNode});

  final TextEditingController controller;
  final double height;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(60)),
          color: Colors.transparent,
          border: Border.all(color: AppColors.mainGrey,width: 1)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(AppIcons.search),
            const SizedBox(width: 5),
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: controller,
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                  border: const OutlineInputBorder(borderSide: BorderSide.none,),
                  hintText: AppTexts.search,
                  hintStyle: TextStyle(fontSize: 12,color: AppColors.mainGrey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
