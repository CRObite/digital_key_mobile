import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/data/repository/transactions_repository.dart';
import 'package:web_com/domain/pageable.dart';
import 'package:web_com/domain/transaction.dart';
import 'package:web_com/widgets/shimmer_box.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_shadow.dart';
import '../../../utils/custom_exeption.dart';
import '../../../widgets/search_app_bar.dart';
import '../../../widgets/status_box.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import '../../review_pages/inner_pages/review_profile.dart';

class FinancePayment extends StatefulWidget {
  const FinancePayment({super.key});

  @override
  State<FinancePayment> createState() => _FinancePaymentState();
}

class _FinancePaymentState extends State<FinancePayment> {

  ScrollController scrollController = ScrollController();
  TextEditingController controller =TextEditingController();
  FocusNode focusNode = FocusNode();
  int size = 10;
  int page = 0;
  int maxPage = 0;
  bool isLoading = false;

  List<Transaction> listOfTransactions = [];

  @override
  void initState() {
    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);
    getTransactions(navigationPageCubit);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (maxPage >= page + 1) {
          page ++;
          getTransactions(navigationPageCubit,needLoading: false);
        }
      }
    });
    super.initState();
  }


  Future<void> getTransactions(NavigationPageCubit navigationPageCubit,{bool needLoading = true}) async {
    try{

      if(needLoading) {
        setState(() {
          isLoading = true;
        });
      }

      Pageable? pageable = await TransactionsRepository().getTransactions(context, page, size);

      if(pageable!= null){

        maxPage = pageable.totalPages;

        for(var item in pageable.content){
          listOfTransactions.add(Transaction.fromJson(item));
        }
      }


      if(needLoading) {
        setState(() {
          isLoading = false;
        });
      }
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        navigationPageCubit.showMessage(exception.message, false);

        setState(() {
          isLoading = false;
        });
      }else{
        rethrow;
      }
    }
  }

  void resetPage(NavigationPageCubit navigationPageCubit){
    page = 0;
    listOfTransactions.clear();
    getTransactions(navigationPageCubit);
  }

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller,isFocused: (value ) {  },),
      body: RefreshIndicator(
        onRefresh: () async{
          resetPage(navigationPageCubit);
        },
        child: isLoading?
        ListView.builder(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 10,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context,index){
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                  child: const ShimmerBox(width: double.infinity, height: 150)
              );
            }
        ):
        ListView.builder(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: listOfTransactions.length + 1,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context,index){

              if(listOfTransactions.isNotEmpty){
                if(index < listOfTransactions.length){
                  return const FinanceCard();
                }else{
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: maxPage <= page + 1
                              ? Text(listOfTransactions.length < size ? '' : 'Больше нет данных')
                              : const CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 90),
                    ],
                  );
                }
              }else{
                return Container(margin:const EdgeInsets.only(top: 30) ,child: const Center(child: Text('Нет данных оплат')),);
              }
            }
        ),
      ),
    );
  }
}


class FinanceCard extends StatelessWidget {
  const FinanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppShadow.shadow,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                Row(
                  children: [
                    const StatusBox(color: Colors.green, text: 'Действующий'),
                    const SizedBox(width: 5,),
                    StatusBox(color: AppColors.mainBlue, text: 'ТОО “Digital Zone'),
                  ],
                ),
                const SizedBox(height: 10,),
                const Text('ТОО "Reverie"',style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 15,),
                const Row(
                  children: [
                    Expanded(child: DoubleTextColumn(text: 'Счет', text2: '№KZWEB000091')),
                    SizedBox(width: 10,),
                    Expanded(child: DoubleTextColumn(text: 'Аккаунт менеджер', text2: '-')),
                  ],
                ),
                const SizedBox(height: 10,),
                const Row(
                  children: [
                    Expanded(child: DoubleTextColumn(text: 'Сумма', text2: '540 000.00 ₸')),
                    SizedBox(width: 10,),
                    Expanded(child: DoubleTextColumn(text: 'Валюта', text2: 'KZT')),
                  ],
                ),
                const SizedBox(height: 10,),
                const Row(
                  children: [
                    Expanded(child: DoubleTextColumn(text: 'Дата оплаты', text2: '08.02.2024')),
                    SizedBox(width: 10,),
                    Expanded(child: DoubleTextColumn(text: 'Форма оплаты', text2: 'Предоплата')),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                IconButton(onPressed: (){}, icon: SvgPicture.asset('assets/icons/ic_delete.svg'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
