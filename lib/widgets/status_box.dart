import 'package:flutter/material.dart';

class StatusBox extends StatelessWidget {
  const StatusBox({super.key, required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1,  color: color,),
          borderRadius: const BorderRadius.all(Radius.circular(50))
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(text, style: TextStyle(color: color, fontSize: 12),),
    );
  }
}
