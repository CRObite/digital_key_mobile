import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/widgets/common_tab_bar.dart';

import '../../config/app_icons.dart';
import '../../config/app_texts.dart';
import '../../widgets/search_app_bar.dart';
import '../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class OfficePage extends StatefulWidget {
  const OfficePage({super.key});

  @override
  State<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage>{


  TextEditingController controller =TextEditingController();

  final _tabs = const [
    Tab(text: 'Tab1'),
    Tab(text: 'Tab2'),
  ];


  @override
  Widget build(BuildContext context) {
    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);
    return Scaffold(
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller,),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CommonTabBar(tabs: _tabs, onPressed: (value){}),

          ],
        ),
      ),
    );
  }
}
