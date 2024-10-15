
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/app_formatter.dart';
import 'package:web_com/config/app_shadow.dart';
import 'package:web_com/config/electronic_invoice_status_enum.dart';
import 'package:web_com/config/invoice_status_enum.dart';
import 'package:web_com/domain/electronic_invoice.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile.dart';
import 'package:web_com/widgets/status_box.dart';

import '../config/currency_symbol.dart';
import '../domain/completion_act.dart';
import '../domain/invoice.dart';

enum FinanceCardType{
  bill, abp, contract
}

class FinanceCard extends StatelessWidget {
  const FinanceCard({super.key, required this.type, required this.selected, this.invoice, this.electronicInvoice, this.completionAct});

  final FinanceCardType type;
  final bool selected;
  final Invoice? invoice;
  final ElectronicInvoice? electronicInvoice;
  final CompletionAct? completionAct;

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
                if(type == FinanceCardType.bill && invoice!= null)
                ...[
                  Row(
                    children: [
                      invoice?.status?.description!= null? StatusBox(color: AppColors.mainGreen, text: invoice?.status?.description ?? ''): const SizedBox(),
                      const SizedBox(width: 5,),
                      invoice?.company?.name!= null? StatusBox(color: AppColors.mainBlue, text: invoice?.company?.name ?? ''): const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text('Счет ${invoice?.documentNumber ??''}',style: const TextStyle(fontWeight: FontWeight.bold),),

                  const SizedBox(height: 15,),
                  DoubleTextColumn(text: 'Клиент', text2: invoice?.client?.name ?? '-'),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(child: DoubleTextColumn(text: 'Договор', text2: invoice?.contract?.number ?? '-')),
                      const SizedBox(width: 10,),
                      Expanded(child: DoubleTextColumn(text: 'Инициатор', text2: invoice?.createdBy?.name ?? '-')),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(child: DoubleTextColumn(text: 'Сумма', text2: '${invoice?.amount ?? '-'} ${invoice?.currency?.code!= null?  CurrencySymbol.getCurrencySymbol(invoice!.currency!.code!): ''}')),
                      const SizedBox(width: 10,),
                      Expanded(child: DoubleTextColumn(text: 'Дата создания', text2: invoice!.invoiceAt!= null? AppFormatter.formatDateTime(invoice!.invoiceAt!): '-')),
                    ],
                  ),
                ],


                if(type == FinanceCardType.abp && completionAct!= null)
                  ...[
                    completionAct?.company?.name!= null?  StatusBox(color: AppColors.mainBlue, text: completionAct?.company?.name ?? ''): const SizedBox(),
                    const SizedBox(height: 10,),
                    Text(completionAct?.name ?? '',style: const TextStyle(fontWeight: FontWeight.bold),),

                    const SizedBox(height: 15,),
                    DoubleTextColumn(text: 'Клиент', text2: completionAct?.client?.name ?? '-'),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(child: DoubleTextColumn(text: 'Сумма', text2: '${completionAct?.sum ?? '-'} ${completionAct?.currency?.code!= null?  CurrencySymbol.getCurrencySymbol(completionAct!.currency!.code!): ''}')),
                        const SizedBox(width: 10,),
                        Expanded(child: DoubleTextColumn(text: 'Менеджер', text2: completionAct?.createdBy?.name ?? '-')),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(child: DoubleTextColumn(text: 'Дата ABP', text2: completionAct!.documentAt!= null? AppFormatter.formatDateTime(completionAct!.documentAt!): '-')),
                        const SizedBox(width: 10,),
                        Expanded(child: DoubleTextColumn(text: 'Договор', text2: completionAct?.contract?.number ?? '-')),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    // Row(
                    //   children: [
                    //     const Expanded(child: DoubleTextColumn(text: 'Счет на оплату', text2: '-')),
                    //     const SizedBox(width: 10,),
                    //     Expanded(child: DoubleTextColumn(text: 'Статус счета', text2: completionAct.contract.con)),
                    //   ],
                    // ),
                  ],

                if(type == FinanceCardType.contract && electronicInvoice!= null)
                  ...[
                    Row(
                      children: [
                        electronicInvoice?.status?.description!= null ? StatusBox(color: AppColors.mainGreen, text: electronicInvoice?.status?.description ?? ''): const SizedBox(),
                        const SizedBox(width: 5,),
                        electronicInvoice?.company?.name!= null ? StatusBox(color: AppColors.mainBlue, text: electronicInvoice?.company?.name ?? ''): const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text('ЭСФ ${electronicInvoice?.identificator ??''}',style: const TextStyle(fontWeight: FontWeight.bold),),

                    const SizedBox(height: 15,),
                    DoubleTextColumn(text: 'Клиент', text2: electronicInvoice?.client?.name ?? '-'),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(child: DoubleTextColumn(text: 'Номер договор', text2: electronicInvoice?.documentNumber ?? '-')),
                        const SizedBox(width: 10,),
                        Expanded(child: DoubleTextColumn(text: 'Договор доставки', text2: electronicInvoice?.contract?.number ?? '-')),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(child: DoubleTextColumn(text: 'Дата ЭСФ', text2: electronicInvoice!.documentAt!= null? AppFormatter.formatDateTime(electronicInvoice!.documentAt!): '-')),
                        const SizedBox(width: 10,),
                        Expanded(child: DoubleTextColumn(text: 'Документ подтверждающий доставку', text2: electronicInvoice?.actNumber ?? '-')),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    DoubleTextColumn(text: 'Дата документa подтверждающий доставку', text2: electronicInvoice?.actAt!= null? AppFormatter.formatDateTime(electronicInvoice!.actAt!) :'-'),
                  ],
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