
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_icons.dart';
import '../../../../data/repository/contract_repository.dart';
import '../../../../domain/contract.dart';
import '../../../../domain/pageable.dart';
import '../../../../utils/custom_exeption.dart';
import '../../../../widgets/contract_card.dart';
import '../../../../widgets/shimmer_box.dart';

class ContractPart extends StatefulWidget {
  const ContractPart({super.key, required this.clientId});

  final int clientId;

  @override
  State<ContractPart> createState() => _ContractPartState();
}

class _ContractPartState extends State<ContractPart> {

  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();

    getNewData();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        getNewData(needLoading: true);
      }
    });
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  List<Contract> listOfValue = [];
  int maxPage = 0;
  int currentPageCount = 0;
  int size = 10;

  bool isLoading = true;

  Future<void> getNewData({bool needLoading = false}) async {

    if(needLoading){
      setState(() {
        isLoading = true;
      });
    }

    try{


      Pageable? value =  await ContractRepository.getContractsByClientId(context, widget.clientId, currentPageCount, size);
      if(value != null){

        maxPage = value.totalPages;
        List<dynamic> dataList = value.content;
        for(var item in dataList){
          listOfValue.add(Contract.fromJson(item));
        }
        setState(() {
          isLoading  = false;
        });
      }
    }catch(e){

      setState(() {
        isLoading  = false;
      });

      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        print(exception.message);
      }else{
        rethrow;
      }
    }
  }

  void resetList(){
    listOfValue.clear();
    maxPage = 0;
    currentPageCount = 0;

    getNewData(needLoading:  true);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index){
                return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const ShimmerBox(width: 500, height: 150)
                );
              }
          )
      ):RefreshIndicator(
        onRefresh: () async {
          resetList();
        },
        child: listOfValue.isNotEmpty ? SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              controller: scrollController,
              itemCount: listOfValue.length + 1,
              itemBuilder: (context, index){

                if (listOfValue.isNotEmpty) {
                  if (index < listOfValue.length) {
                    return ContractCard(index: index, onDeletePressed: () {  }, contract: listOfValue[index],);
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: maxPage - 1 <= currentPageCount
                                ? Text(listOfValue.length < size ? '' : 'Больше нет данных')
                                : CircularProgressIndicator(color: AppColors.mainBlue),
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    );
                  }
                } else {
                  return const SizedBox();
                }
              }
          ),
        ): const Center(
          child: Text('Для данного клиента договоры не найдены'),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () async {
          await context.pushNamed('contractCreatingPage');
          resetList();
        },
        child: SvgPicture.asset(AppIcons.addContract),
      ),
    );
  }
}