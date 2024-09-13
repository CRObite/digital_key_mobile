import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:web_com/config/app_colors.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.borderGrey.withOpacity(0.5),
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.borderGrey,
          borderRadius: const BorderRadius.all(Radius.circular(12))
        ),
      )
    );
  }
}
