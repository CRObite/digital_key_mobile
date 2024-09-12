import 'package:flutter/material.dart';

class StatusBox extends StatelessWidget {
  const StatusBox({super.key, required this.color, required this.text, this.selected = false, this.onPressed});

  final Color color;
  final String text;
  final bool selected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(onPressed!= null){
          onPressed!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border: selected ? null: Border.all(width: 1, color: color,),
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: selected ? color: null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(text, style: TextStyle(color: selected? Colors.white : color, fontSize: 12),),
      ),
    );
  }
}
