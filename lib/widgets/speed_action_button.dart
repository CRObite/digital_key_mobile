import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../config/app_colors.dart';
import '../config/app_icons.dart';

class SpeedActionButton extends StatelessWidget {
  const SpeedActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: AppColors.mainBlue,
      spaceBetweenChildren: 10,
      childPadding: const EdgeInsets.all(0),
      children: [
        SpeedDialChild(
            shape: const CircleBorder(),
            child:  SvgPicture.asset(AppIcons.telegram),
            onTap: (){

            },
            backgroundColor: const Color(0xffD7E9F8)
        ),
        SpeedDialChild(
            shape: const CircleBorder(),
            child: SvgPicture.asset(AppIcons.edit),
            onTap: (){
              context.push('/chatPage');
            },
            backgroundColor: AppColors.mainBlue
        )
      ],
      child: SvgPicture.asset(AppIcons.message),
    );
  }
}
