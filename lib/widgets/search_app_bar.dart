import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/widgets/search_field.dart';
import '../config/app_icons.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
    required this.onMenuButtonPressed,
    required this.isRed,
    required this.searchController,
    required this.isFocused,
  });

  final VoidCallback onMenuButtonPressed;
  final bool isRed;
  final TextEditingController searchController;
  final Function(bool) isFocused;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  FocusNode focusNode = FocusNode();
  bool focused = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (!focused && focusNode.hasFocus) {
        setState(() {
          focused = focusNode.hasFocus;
        });
        widget.isFocused(focused);
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: focused
                ? const SizedBox()
                : InkWell(
              onTap: () {
                widget.onMenuButtonPressed();
              },
              child: SvgPicture.asset(AppIcons.menu),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: focused ? 0 : 15,
          ),
          Expanded(
            child: SearchField(
              controller: widget.searchController,
              height: 45,
              focusNode: focusNode,
            ),
          ),
          const SizedBox(width: 15),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: focused
                ? TextButton(
              onPressed: () {
                if (focusNode.hasFocus) {
                  focusNode.unfocus();
                }
                setState(() {
                  focused = false;
                });
                widget.isFocused(focused);
              },
              child: Text(
                'Отмена',
                style: TextStyle(color: AppColors.secondaryBlueDarker),
              ),
            )
                : SvgPicture.asset(
              widget.isRed
                  ? AppIcons.notificationRed
                  : AppIcons.notification,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
