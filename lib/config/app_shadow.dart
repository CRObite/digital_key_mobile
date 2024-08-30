import 'package:flutter/cupertino.dart';

class AppShadow{
  static List<BoxShadow> shadow = [
    const BoxShadow(
      color: Color.fromRGBO(223, 231, 239, 1), // The color of the shadow
      offset: Offset(2, 3), // The horizontal and vertical offset
      blurRadius: 5, // The blur radius
      spreadRadius: 1, // The spread radius
    ),
  ];

  static List<BoxShadow> containerShadow = [
    const BoxShadow(
      color: Color.fromRGBO(223, 231, 239, 0.25),
      blurRadius: 10, // Equivalent to the 10px blur in CSS
      spreadRadius: 2, // Equivalent to the 2px spread in CSS
      offset: Offset(0, 0), // Equivalent to the 0px 0px offset in CSS
    ),
  ];
}