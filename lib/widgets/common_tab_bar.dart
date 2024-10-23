import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class CommonTabBar extends StatefulWidget {
  const CommonTabBar({super.key, required this.tabs, required this.onPressed, this.isIcons = false, required this.selectedValue});


  final List<Tab> tabs;
  final Function(int) onPressed;
  final bool isIcons;
  final int selectedValue;

  @override
  State<CommonTabBar> createState() => _CommonTabBarState();
}

class _CommonTabBarState extends State<CommonTabBar> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.tabs.length, vsync: this,initialIndex: widget.selectedValue);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      child: TabBar(

        dividerColor: Colors.transparent,
        controller: _tabController,
        tabs: widget.tabs,
        labelStyle: const TextStyle(fontSize: 12),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.mainGrey,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          color: AppColors.mainBlue,
        ),
        onTap:(value){
          widget.onPressed(value);
        } ,
      ),
    );
  }
}
