import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_icons.dart';
import 'package:web_com/widgets/search_app_bar.dart';

import '../../config/app_colors.dart';
import '../../config/app_texts.dart';
import '../../widgets/speed_action_button.dart';
import '../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {


  int currentPage = 0;

  void goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );

    setState(() {
      currentPage = index;
    });
  }



  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(


        body: widget.navigationShell,

        floatingActionButton: currentPage == 0 ? const SpeedActionButton(): null,

        bottomNavigationBar:  NavigationBar(
          indicatorColor: AppColors.mainBlue,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(seconds: 1),
          selectedIndex: currentPage,
          onDestinationSelected: (index) {
            goToBranch(index);
          },
          destinations: _navBarItems,

        ),
    );
  }
}

List<NavigationDestination> _navBarItems = [
  NavigationDestination(
    icon: SvgPicture.asset(AppIcons.stats),
    selectedIcon: SvgPicture.asset(AppIcons.stats,colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),),
    label: AppTexts.statistics,
  ),
  NavigationDestination(
    icon: SvgPicture.asset(AppIcons.office, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),),
    selectedIcon: SvgPicture.asset(AppIcons.office),
    label: AppTexts.office,
  ),
  NavigationDestination(
    icon: SvgPicture.asset(AppIcons.profile),
    selectedIcon: SvgPicture.asset(AppIcons.profile,colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),),
    label: AppTexts.profile,
  ),
];