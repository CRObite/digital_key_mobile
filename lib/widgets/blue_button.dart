import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({super.key, required this.onPressed, required this.iconPath});

  final VoidCallback onPressed;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff7CBCE8),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () { onPressed(); },
        icon: SvgPicture.asset(
          iconPath,
        ),
      ),
    );
  }
}