import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_formatter.dart';
import 'package:web_com/config/currency_symbol.dart';
import 'package:web_com/config/service_operation_payform_enum.dart';
import 'package:web_com/config/service_operation_status_enum.dart';
import 'package:web_com/config/service_operation_type_enum.dart';
import 'package:web_com/domain/service_operation.dart';
import 'package:web_com/widgets/status_box.dart';

import '../config/app_box_decoration.dart';
import '../config/app_colors.dart';
import '../screens/review_pages/inner_pages/review_profile.dart';
import 'direction_row.dart';

class DepositCard extends StatelessWidget {
  const DepositCard({super.key, required this.operation});

  final ServiceOperation operation;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: AppBoxDecoration.boxWithShadow,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                operation.status?.description!= null ? StatusBox(color: AppColors.mainBlue, text: operation.status?.description ?? ''): const SizedBox(),
                const SizedBox(width: 5,),
                operation.type != null ? StatusBox(color: AppColors.mainGreen, text: operation.type?.description ?? '') : const SizedBox(),
              ],
            ),

            const SizedBox(height: 10,),

            DirectionRow(operation: operation,),

            const SizedBox(height: 15,),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DoubleTextColumn(text: 'Номер счета', text2: operation.invoice?.documentNumber ?? '-',),
                      const SizedBox(height: 10,),
                      DoubleTextColumn(text: 'Дата оплаты', text2: operation.transaction?.statementDate ?? '-',),
                      const SizedBox(height: 10,),
                      DoubleTextColumn(text: 'Дата зачисления', text2: operation.executedAt != null ?  AppFormatter.formatDateTime(operation.executedAt!) : '-',),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DoubleTextColumn(text: 'ID кабинета для зачисления', text2: operation.toService?.adsAccount ?? '-',),
                      const SizedBox(height: 10,),
                      DoubleTextColumn(text: 'Курс зачисления', text2: operation.rate!= null ? operation.rate.toString(): '-',),
                      const SizedBox(height: 10,),
                      DoubleTextColumn(
                        text: 'Сумма зачисления',
                        text2: operation.amount != null? AppFormatter().formatCurrency(
                            operation.amount!,
                            operation.toService?.currency?.code != null ?
                            CurrencySymbol.getCurrencySymbol(operation.toService!.currency!.code!) : operation.fromService?.currency?.code != null ?
                            CurrencySymbol.getCurrencySymbol(operation.fromService!.currency!.code!): '',
                            2
                        ): '-',),
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
