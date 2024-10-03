import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class CountTextRow extends StatelessWidget {
  const CountTextRow({super.key, required this.count, required this.text});

  final int count;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: AppColors.secondaryBlueDarker,
                shape: BoxShape.circle
            ),
            child: Center(child: Text('$count', style: const TextStyle(fontSize: 12,color: Colors.white),)),
          ),

          const SizedBox(width: 10,),

          Text(text,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
