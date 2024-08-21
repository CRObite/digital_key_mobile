import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/app_colors.dart';
import '../config/app_icons.dart';
import '../config/app_texts.dart';
import 'expanded_button.dart';

class AlternativeEnteringButtons extends StatelessWidget {
  const AlternativeEnteringButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandedButton(
            backgroundColor: Colors.white,
            sideColor: AppColors.secondaryBlueDarker,
            onPressed: (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.google),
                  Expanded(child: Text(AppTexts.googleEnter, textAlign: TextAlign.center ,style: TextStyle(color: AppColors.mainGrey),)),
                ],
              ),
            )
        ),
        const SizedBox(height: 10,),
        ExpandedButton(
            backgroundColor: Colors.white,
            sideColor: AppColors.secondaryBlueDarker,
            onPressed: (){},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.yandex),
                  Expanded(child: Text(AppTexts.yandexEnter, textAlign: TextAlign.center ,style: TextStyle(color: AppColors.mainGrey),)),
                ],
              ),
            )
        ),
      ],
    );
  }
}
