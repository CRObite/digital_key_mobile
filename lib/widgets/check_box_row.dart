import 'package:flutter/material.dart';
import 'package:web_com/config/app_colors.dart';

class CheckBoxRow extends StatefulWidget {
  const CheckBoxRow({super.key, this.isChecked = false, required this.onPressed, required this.child, this.height, this.isCircle = false});

  final Widget child;
  final bool isChecked;
  final Function(bool) onPressed;
  final double? height;
  final bool isCircle;

  @override
  State<CheckBoxRow> createState() => _CheckBoxRowState();
}

class _CheckBoxRowState extends State<CheckBoxRow> {

  bool checked = false;

  @override
  void didUpdateWidget(covariant CheckBoxRow oldWidget) {
    if(oldWidget.isChecked != widget.isChecked){
      setState(() {
        checked = widget.isChecked;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    checked = widget.isChecked;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: GestureDetector(
        onTap: (){
          setState(() {
            checked = !checked;
          });
          widget.onPressed(checked);
        },
        child: Row(
          children: [
            Checkbox(

                checkColor: widget.isCircle ? AppColors.secondaryBlueDarker : Colors.white,
                shape: widget.isCircle ? RoundedRectangleBorder(
                  borderRadius:  BorderRadius.circular(50.0), // High value to make it circular
                ) : null,
                side: BorderSide(width: widget.isCircle ? 1.5:  1, color: const Color(0xff4B5563)),
                activeColor: AppColors.secondaryBlueDarker,
                value: checked,
                onChanged: (value){
                  if(value!= null){

                    setState(() {
                      checked = value;
                    });
                    widget.onPressed(value);
                  }

                }),

            Flexible(child: widget.child)
          ],
        ),
      ),
    );
  }
}
