import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class ExpandedButton extends StatelessWidget {
  const ExpandedButton({super.key, required this.child, required this.onPressed, this.backgroundColor, this.sideColor});

  final Widget child;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? sideColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()=> onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.secondaryBlueDarker,
        padding: const EdgeInsets.symmetric(vertical: 17),
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
