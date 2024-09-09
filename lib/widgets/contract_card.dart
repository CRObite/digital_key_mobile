import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/config/app_formatter.dart';
import 'package:web_com/config/client_enum.dart';
import 'package:web_com/domain/contract.dart';
import 'package:web_com/widgets/status_box.dart';

import '../config/app_colors.dart';
import '../config/app_texts.dart';
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StatusBox(color: AppColors.secondaryBlueDarker, text: contract.contractState!.type!.description),
                    const SizedBox(width: 10,),
                    StatusBox(color: contract.expiration!.daysLeft! <= 3 ? Colors.red: const Color(0xffEAB308), text: '${AppTexts.daysUntilDelete} ${contract.expiration!.daysLeft}')
                  ],
                ),
                const SizedBox(height: 5,),
                Text(contract.number ?? 'Договор Без номера',style: const TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 5,),
                DoubleTextColumn(text: 'Клиент', text2: contract.client!.name ?? '-',),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DoubleTextColumn(text: 'Дата договора', text2: contract.createdAt!= null ? AppFormatter.formatDateTime(contract.createdAt!) : '-',),
                          DoubleTextColumn(text: 'Дата окончания', text2: contract.expiration!.expiresAt!= null ? AppFormatter.formatDateTime(contract.expiration!.expiresAt!) : '-',),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DoubleTextColumn(text: 'Форма валюта', text2: contract.currency != null ? contract.currency!.code ?? '-': '-'),
                          DoubleTextColumn(text: 'Организация', text2: contract.currency != null ? contract.company!.name ?? '-': '-',),
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
