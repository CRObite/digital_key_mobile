import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/domain/contract.dart';
import 'package:web_com/widgets/status_box.dart';

import '../config/app_colors.dart';
import '../screens/review_pages/inner_pages/review_profile.dart';

class ContractCard extends StatelessWidget {
  const ContractCard({super.key, required this.index, required this.onDeletePressed, required this.contract});

  final int index;
  final VoidCallback onDeletePressed;
  final Contract contract;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: index != 4 ?  10: 80),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.borderGrey),
          borderRadius: const BorderRadius.all(Radius.circular(12))
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusBox(color: Colors.green, text: 'Активный'),
                SizedBox(height: 5,),
                Text('Договор “32255-КД-Б”',style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                DoubleTextColumn(text: 'Клиент', text2: 'Тест',),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DoubleTextColumn(text: 'Дата договора', text2: '16/08/2021',),
                          DoubleTextColumn(text: 'Дата окончания', text2: '16/08/2022',),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DoubleTextColumn(text: 'Форма валюта', text2: 'USD',),
                          DoubleTextColumn(text: 'Организация', text2: 'Digital Zone',),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          IconButton(onPressed: (){onDeletePressed();}, icon: SvgPicture.asset('assets/icons/ic_delete.svg'))
        ],
      ),
    );
  }
}
