
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/app_shadow.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile.dart';
import 'package:web_com/widgets/status_box.dart';

enum FinanceCardType{
  bill, abp, contract
}

class FinanceCard extends StatelessWidget {
  const FinanceCard({super.key, required this.type, required this.selected});

  final FinanceCardType type;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppShadow.shadow,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: selected ? Border.all(width: 1, color: AppColors.mainBlue): null,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusBox(color: AppColors.mainBlue, text: 'Выставлен'),
                const SizedBox(height: 10,),
                const Text('Счет KZ240000543',style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 15,),
                if(type == FinanceCardType.abp)
                  const Row(
                    children: [
                      Expanded(child: DoubleTextColumn(text: 'Договор', text2: '-')),
                      SizedBox(width: 10,),
                      Expanded(child: DoubleTextColumn(text: 'Дата ABP', text2: '08.02.2024')),
                    ],
                  ),
                if(type == FinanceCardType.bill)
                  const DoubleTextColumn(text: 'Договор', text2: '12242022-СУ_12.12.2022'),
                if(type == FinanceCardType.contract)
                  const DoubleTextColumn(text: 'Дата договора', text2: '08.02.2024 00:00'),
                const SizedBox(height: 10,),
                if(type == FinanceCardType.bill)
                  const Row(
                    children: [
                      Expanded(child: DoubleTextColumn(text: 'Сумма', text2: '540 000.00 ₸')),
                      SizedBox(width: 10,),
                      Expanded(child: DoubleTextColumn(text: 'Дата выставления', text2: '08.02.2024')),
                    ],
                  ),
                if(type == FinanceCardType.abp)
                  const Row(
                    children: [
                      Expanded(child: DoubleTextColumn(text: 'Сумма', text2: '540 000.00 ₸')),
                      SizedBox(width: 10,),
                      Expanded(child: DoubleTextColumn(text: 'Счет на оплату', text2:'-')),
                    ],
                  ),
                if(type == FinanceCardType.contract)
                  const DoubleTextColumn(text: 'Дата окончания', text2: '08.02.2025 00:00'),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                InkWell(
                  onTap: (){},
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xffEBF4FC),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset('assets/icons/ic_download.svg'),
                  ),
                ),
                const SizedBox(height: 10,),
                if(type == FinanceCardType.bill)
                  IconButton(onPressed: (){}, icon: SvgPicture.asset('assets/icons/ic_delete.svg'))

              ],
            ),
          ),
        ],
      ),
    );
  }
}