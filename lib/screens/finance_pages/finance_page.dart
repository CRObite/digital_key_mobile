import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../config/app_texts.dart';
import '../../widgets/speed_action_button.dart';
import '../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {

  TextEditingController controller =TextEditingController();
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(


      body: widget.navigationShell,

      floatingActionButton: currentPage != 1 ?  const SpeedActionButton(): null,

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
    icon: SvgPicture.asset(AppIcons.bankCard),
    selectedIcon: SvgPicture.asset(AppIcons.bankCard,colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),),
    label: AppTexts.payment,
  ),
  NavigationDestination(
    icon: SvgPicture.asset(AppIcons.document, colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),),
    selectedIcon: SvgPicture.asset(AppIcons.document),
    label: AppTexts.documents,
  ),
];