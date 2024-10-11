import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/screens/review_pages/inner_pages/statistic_details_parts/line_chart_part.dart';
import 'package:web_com/screens/review_pages/inner_pages/statistic_details_parts/pie_chart_part.dart';

import '../../../widgets/common_tab_bar.dart';

class StatisticDetails extends StatefulWidget {
  const StatisticDetails({super.key});

  @override
  State<StatisticDetails> createState() => _StatisticDetailsState();
}

class _StatisticDetailsState extends State<StatisticDetails> {


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
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 15,
            )),
        title: Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(right: 40),
              child: const Text('Google Ads',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            )),
      ),
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


