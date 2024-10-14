
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/app_box_decoration.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_icons.dart';
import '../../../../domain/bank.dart';
import '../../../../domain/contacts_card_info.dart';
import '../../../../domain/currency.dart';
import '../../../../widgets/check_box_row.dart';
import '../../../../widgets/circle_check.dart';
import '../../../../widgets/lazy_drop_down.dart';
import '../../../../widgets/titled_field.dart';
import '../../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class BankPart extends StatelessWidget {
  const BankPart({super.key, required this.listOBankInfo, required this.bankSelected, required this.currencySelected, required this.mainAccountChange, required this.deleteAccount, required this.navigationPageCubit, required this.addAccount,});

  final List<BankCardInfo> listOBankInfo;
  final Function(int,Bank) bankSelected;
  final Function(int,Currency) currencySelected;
  final Function(int, bool) mainAccountChange;
  final Function(int) deleteAccount;
  final VoidCallback addAccount;
  final NavigationPageCubit navigationPageCubit;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: listOBankInfo.isNotEmpty ? ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          itemCount: listOBankInfo.length,
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.only(bottom: index != listOBankInfo.length - 1 ?  10: 80),
              width: double.infinity,
              decoration: AppBoxDecoration.boxWithShadow,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  LazyDropDown(
                    navigationPageCubit: navigationPageCubit,
                    selected: (Bank value) {
                      bankSelected(index,value);
                    },
                    currentValue: listOBankInfo[index].selected,
                    title: 'Банк',
                    important: true,
                  ),
                  const SizedBox(height: 10,),
                  TitledField(controller: listOBankInfo[index].bankAccount, title: 'Номер счета', type: TextInputType.text,important: true,),
                  const SizedBox(height: 10,),
                  const Text('Валюта',style: TextStyle(fontSize: 12, color: Colors.black),),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                        itemCount: listOBankInfo[index].listOfCurrency.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,currencyIndex){
                          return SizedBox(
                              width:70,
                              child: Row(
                                children: [
                                  CircleCheck(checked:listOBankInfo[index].currencySelected != null ? listOBankInfo[index].listOfCurrency[currencyIndex].id == listOBankInfo[index].currencySelected!.id : false, onPressed: (value) {
                                    if(value){
                                      currencySelected(index,listOBankInfo[index].listOfCurrency[currencyIndex]);
                                    }
                                  },
                                  ),
                                  const SizedBox(width: 10,),
                                  Text(listOBankInfo[index].listOfCurrency[currencyIndex].code ?? '',style: const TextStyle(fontSize: 10),)
                                ],
                              )
                          );
                        }
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckBoxRow(
                          height: 30,
                          isChecked: listOBankInfo[index].mainAccount,
                          onPressed: (value) {
                            mainAccountChange(index,value);
                          },
                          child: const Text('Основной счет',style: TextStyle(fontSize: 12),),
                        ),
                      ),

                      IconButton(onPressed: (){deleteAccount(index);}, icon: SvgPicture.asset(AppIcons.delete))
                    ],
                  ),
                ],
              ),
            );
          }
      ): const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(child: Text('Банковских счетов нет, его можно добавить нажав на иконку ниже',textAlign: TextAlign.center,),),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () {
          addAccount();
        },
        child: SvgPicture.asset('assets/icons/ic_add_bank.svg'),
      ),

    );
  }
}