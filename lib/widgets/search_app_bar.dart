import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/widgets/search_field.dart';

import '../config/app_icons.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key, required this.onMenuButtonPressed, required this.isRed, required this.searchController});

  final VoidCallback onMenuButtonPressed;
  final bool isRed;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          InkWell(
              onTap: (){
                onMenuButtonPressed();
              },
              child: SvgPicture.asset(AppIcons.menu)
          ),
          const SizedBox(width: 15),
          Expanded(
              child: SearchField(
                controller: searchController,
                height: 45,
              )),
          const SizedBox(width: 15),
          SvgPicture.asset(
              isRed ? AppIcons.notificationRed : AppIcons.notification),
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
