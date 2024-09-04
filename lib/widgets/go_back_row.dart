

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoBackRow extends StatelessWidget {
  const GoBackRow({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: (){context.pop();}, icon: const Icon(Icons.arrow_back_ios_new, size: 15,)),
        Text(title, style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
      ],
    );
  }
}
