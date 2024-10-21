import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/domain/client_contract_service.dart';

import '../../../config/app_box_decoration.dart';
import '../../../widgets/deposit_card.dart';
import '../../../widgets/go_back_row.dart';

import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import 'cabinet_parts/cabinet_part.dart';

class CabinetDetails extends StatefulWidget {
  const CabinetDetails({super.key, required this.ccs});

  final ClientContractService ccs;

  @override
  State<CabinetDetails> createState() => _CabinetDetailsState();
}

class _CabinetDetailsState extends State<CabinetDetails> {

  TextEditingController textController =TextEditingController();
  final ScrollController controller = ScrollController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: textController, isFocused: (value ) {  },),

      body: Column(
        children: [
          GoBackRow(title: widget.ccs.name ?? ''),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: AppBoxDecoration.boxWithShadow,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Scrollbar(
                    controller: controller,
                    thumbVisibility: true,
                    child: ScrollableRow(controller: controller, clientContractService: widget.ccs)
                ),
              ),
            ),
          ),

          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('История зачислений',style: TextStyle(fontSize: 16, fontWeight:FontWeight.bold),),
                TextButton(
                  onPressed: (){context.push('/enrollmentHistory');},
                  child: Text('Смотреть все',style: TextStyle(fontSize: 12, color: AppColors.mainBlue),),
                )
              ],
            ),
          ),

          const SizedBox(height: 20,),

          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 3,
                itemBuilder: (context,index){
                  return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const DepositCard()
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}


