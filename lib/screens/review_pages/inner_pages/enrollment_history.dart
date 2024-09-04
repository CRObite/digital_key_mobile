import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';

import '../../../config/app_icons.dart';
import '../../../widgets/deposit_card.dart';
import '../../../widgets/go_back_row.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class EnrollmentHistory extends StatefulWidget {
  const EnrollmentHistory({super.key});

  @override
  State<EnrollmentHistory> createState() => _EnrollmentHistoryState();
}

class _EnrollmentHistoryState extends State<EnrollmentHistory> {

  TextEditingController textController =TextEditingController();

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: textController,),

      body: Column(
        children: [
          const GoBackRow(title: 'История зачислений'),

          const SizedBox(height: 10,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20, child: Image.asset('assets/images/vk.png')),
                const SizedBox(width: 5,),
                Flexible(child: Text('Название аккаунта', style: TextStyle(color: AppColors.secondaryGreyDarker),maxLines: 1,overflow: TextOverflow.ellipsis,))
              ],
            ),
          ),

          const SizedBox(height: 10,),

          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 10,
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

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () { context.push('/newOperation'); },
        child: SvgPicture.asset(AppIcons.addContract),
      ),
    );
  }
}
