import 'package:flutter/material.dart';
import 'package:web_com/config/app_colors.dart';

class CircleCheck extends StatelessWidget {
  const CircleCheck({super.key, required this.checked, required this.onPressed});

  final bool checked;
  final Function(bool) onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed(!checked);
      },
      child: SizedBox(
        width: 16,
        height: 16,
        child: Stack(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration:  BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: checked ? Border.all(width: 1,color: AppColors.secondaryBlueDarker):  Border.all(width: 1,color: Colors.grey)
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      color: checked ? AppColors.secondaryBlueDarker: Colors.white,
                      shape: BoxShape.circle
                  ),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
