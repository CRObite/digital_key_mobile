
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/screens/review_pages/inner_pages/statistic_details_parts/line_chart_part.dart';
import 'package:web_com/screens/review_pages/inner_pages/statistic_details_parts/pie_chart_part.dart';

import '../../../widgets/common_tab_bar.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class ReviewStatistics extends StatefulWidget {
  const ReviewStatistics({super.key});

  @override
  State<ReviewStatistics> createState() => _ReviewStatisticsState();
}

class _ReviewStatisticsState extends State<ReviewStatistics> {

  TextEditingController controller = TextEditingController();

  int selected = 0;
  final _tabs = [
    const Tab(
      icon: Icon(CupertinoIcons.chart_pie),
    ),
    const Tab(
      icon: Icon(CupertinoIcons.graph_square),
    ),
  ];


  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller,isFocused: (value) {  },),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CommonTabBar(
                  tabs: _tabs,
                  onPressed: (value) {
                    setState(() {
                      selected = value;
                    });
                  }),
            ),

            if(selected == 0)
              const PieChartPart(),
            if(selected == 1)
              const LineChartPart(),
          ],
        ),
      ),
    );
  }
}
