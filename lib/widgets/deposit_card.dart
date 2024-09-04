import 'package:flutter/material.dart';
import 'package:web_com/widgets/status_box.dart';

import '../config/app_box_decoration.dart';
import '../config/app_colors.dart';
import '../screens/review_pages/inner_pages/review_profile.dart';
import 'direction_row.dart';

class DepositCard extends StatelessWidget {
  const DepositCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: AppBoxDecoration.boxWithShadow,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                StatusBox(color: AppColors.mainBlue, text: 'Пополнение'),
                const SizedBox(width: 5,),
                StatusBox(color: AppColors.mainGreen, text: 'Активный'),
              ],
            ),

            const SizedBox(height: 10,),

            const DirectionRow(title: 'Название аккаунта', icon: 'assets/images/vk.png',),

            const SizedBox(height: 15,),

            const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DoubleTextColumn(text: 'Номер счета', text2: '2400001254',),
                      SizedBox(height: 10,),
                      DoubleTextColumn(text: 'Дата оплаты', text2: '16.08.2022 14:35',),
                      SizedBox(height: 10,),
                      DoubleTextColumn(text: 'Дата зачисления', text2: '16.08.2022 14:35',),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DoubleTextColumn(text: 'ID кабинета для зачисления', text2: '748-405-5520',),
                      SizedBox(height: 10,),
                      DoubleTextColumn(text: 'Курс зачисления', text2: '451',),
                      SizedBox(height: 10,),
                      DoubleTextColumn(text: 'Сумма зачисления', text2: '440',iconPath: 'assets/icons/ic_money.svg',),
                    ],
                  ),
                ),
              ],
            )

          ],
        )
    );
  }
}
