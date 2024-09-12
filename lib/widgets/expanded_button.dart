import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class ExpandedButton extends StatelessWidget {
  const ExpandedButton({super.key, required this.child, required this.onPressed, this.backgroundColor, this.sideColor, this.innerPaddingY = 17 });

  final Widget child;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? sideColor;
  final double innerPaddingY;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()=> onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.mainBlue,
        padding: EdgeInsets.symmetric(vertical: innerPaddingY),
        minimumSize: const Size(double.infinity, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: sideColor!= null ? BorderSide(color: sideColor!, width: 1): const BorderSide(width: 0, color: Colors.transparent) ,
        ),
      ),
      child: child,
    );
  }
}
