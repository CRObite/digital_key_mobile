import 'package:flutter/material.dart';
import 'package:web_com/config/app_colors.dart';

class CheckBoxRow extends StatelessWidget {
  const CheckBoxRow({super.key,required this.isChecked, required this.onPressed, required this.child, this.height, this.isCircle = false});

  final Widget child;
  final bool isChecked;
  final Function(bool) onPressed;
  final double? height;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: GestureDetector(
        onTap: (){
          onPressed(true);
        },
        child: Row(
          children: [
            Checkbox(

                checkColor: isCircle ? AppColors.secondaryBlueDarker : Colors.white,
                shape: isCircle ? RoundedRectangleBorder(
                  borderRadius:  BorderRadius.circular(50.0), // High value to make it circular
                ) : null,
                side: BorderSide(width: isCircle ? 1.5:  1, color: const Color(0xff4B5563)),
                activeColor: AppColors.secondaryBlueDarker,
                value: isChecked,
                onChanged: (value){
                  if(value!= null){
                    onPressed(value);
                  }

                }),

            Flexible(child: child)
          ],
        ),
      ),
    );
  }
}
