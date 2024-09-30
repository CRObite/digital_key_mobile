import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_colors.dart';
import '../config/app_texts.dart';

class MonthsBuilder extends StatelessWidget {
  const MonthsBuilder({super.key, required this.currentMonthIndex, required this.selectedMonth, required this.onPressed});

  final int currentMonthIndex;
  final int selectedMonth;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {

    List<String> firstPart = AppTexts.months.sublist(0, currentMonthIndex + 1).reversed.toList();
    List<String> secondPart = AppTexts.months.sublist(currentMonthIndex + 1);
    
    List<String> combinedList = [...firstPart, ...secondPart.reversed];

    int selected = combinedList.indexOf(AppTexts.months[selectedMonth]);
    
    return SizedBox(
      height: 30,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: AppTexts.months.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              onPressed(AppTexts.months.indexOf(combinedList[index]));
            },
            child: Container(
                margin: EdgeInsets.only(right: index != combinedList.length-1? 40: 0),
                child: Column(
                  children: [
                    Text(
                      combinedList[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: selected == index ? AppColors.secondaryBlueDarker : null,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    selected == index? Container(
                      height: 3, width: MediaQuery.of(context).size.width * 0.08,
                      decoration: BoxDecoration(
                          color: AppColors.secondaryBlueDarker,
                          borderRadius: const BorderRadius.all(Radius.circular(20))
                      ),
                    ): const SizedBox()
                  ],
                )
            ),
          );
        },
      ),
    );
  }
}
