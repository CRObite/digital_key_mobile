import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/app_texts.dart';
import 'package:web_com/data/repository/file_repository.dart';
import 'package:web_com/screens/navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import 'package:web_com/screens/navigation_page/side_bar_cubit/side_bar_cubit.dart';

import '../../config/app_icons.dart';
import '../../domain/currency_rates.dart';
import '../../domain/user.dart';
import '../../widgets/toast_widget.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with SingleTickerProviderStateMixin {
  bool opened = false;

  late AnimationController _animationController;
  late Animation animation;
  late Animation scaleAnimation;

  NavigationPageCubit navigationPageCubit = NavigationPageCubit();

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  int currentPage = 0;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => navigationPageCubit,
      child: BlocListener<NavigationPageCubit,NavigationPageState>(
        listener: (context,state){
          if(state is NavigationPageOpened){
            _animationController.forward();
            setState(() {
              opened = true;
            });
          }else if(state is NavigationPageClosed){
            _animationController.reverse();
            setState(() {
              opened = false;
            });
          }else if(state is NavigationPageMessage) {
            ToastWidget.show(context, state.message,state.positive);
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xff4B5563),
          extendBody: false,
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 10 && !opened) {
                navigationPageCubit.openDrawer();
              } else if (details.delta.dx < -10 && opened) {
                navigationPageCubit.closeDrawer();
              }
            },
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  width: 250,
                  left: opened ? 0 : -250,
                  height: MediaQuery.of(context).size.height,
                  child: CustomSideBar(
                    onSectionPressed: (value) {
                      navigationPageCubit.goToBranch(widget.navigationShell, value);
                      navigationPageCubit.closeDrawer();
                    },
                  ),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(animation.value - 30 * animation.value * pi / 180),
                  child: Transform.translate(
                    offset: Offset(animation.value * 220, 0),
                    child: Transform.scale(
                      scale: scaleAnimation.value,
                      child: GestureDetector(
                        onTap: () {
                          if (opened) {
                            navigationPageCubit.closeDrawer();
                          }
                        },
                        child: AbsorbPointer(
                          absorbing: opened,
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.all(Radius.circular(opened ? 40 : 0)),
                            child: widget.navigationShell,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}

class CustomSideBar extends StatefulWidget {
  const CustomSideBar({super.key, required this.onSectionPressed});

  final Function(int) onSectionPressed;

  @override
  State<CustomSideBar> createState() => _CustomSideBarState();
}

class _CustomSideBarState extends State<CustomSideBar> {
  Map<String, String> sections = {
    AppIcons.review: AppTexts.review,
    AppIcons.finance: AppTexts.finance,
    AppIcons.services: AppTexts.services,
    AppIcons.report: AppTexts.report,
    AppIcons.favorite: AppTexts.favorite,
    AppIcons.faq: AppTexts.faq,
    AppIcons.news: AppTexts.news,
  };

  int selectedSection = 0;

  SideBarCubit sideBarCubit = SideBarCubit();

  List<CurrencyRates> listOfCurrency = [];
  User? user;

  @override
  void initState() {
    sideBarCubit.getSideBarData(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sideBarCubit,
      child: BlocListener<SideBarCubit,SideBarState>(
        listener: ( context, state) {
          if(state is SideBarSuccess){
            setState(() {
              listOfCurrency = state.listOfCurrency;
              user = state.user;
            });
          }
        },
        child: SizedBox(
          height: double.infinity,
          child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                      if(user != null)
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white24,
                            child: user!.avatar != null
                                ? FutureBuilder<Uint8List?>(
                              future: FileRepository.getImageFile(context, user!.avatar!.url,user!.avatar!.id),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Error loading image');
                                } else if (snapshot.hasData) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  );
                                } else {
                                  return const Text('No image data found');
                                }
                              },
                            ) : const Icon(
                              CupertinoIcons.person,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: '5 645 546',
                                        style: TextStyle(color: Colors.white)),
                                    TextSpan(
                                        text: ',56 ₸',
                                        style:
                                        TextStyle(color: AppColors.mainGrey)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                        text: '12 546',
                                        style: TextStyle(color: Colors.white)),
                                    TextSpan(
                                        text: ',56 \$',
                                        style:
                                        TextStyle(color: AppColors.mainGrey)),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                    const SizedBox(
                      height: 35,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: sections.length,
                        itemBuilder: (context, index) {
                          var entry = sections.entries.elementAt(index);
                          String icon = entry.key;
                          String text = entry.value;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSection = index;
                              });

                              widget.onSectionPressed(index);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: index == selectedSection
                                      ? AppColors.mainBlue
                                      : Colors.transparent,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                              child: Row(
                                children: [
                                  SvgPicture.asset(icon),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    text,
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 35,
                    ),

                    if(listOfCurrency.isNotEmpty)
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: listOfCurrency.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: index != 2 ? 4 : 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.mainGrey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          listOfCurrency[index].currency.code ?? '',
                                          style:
                                          TextStyle(color: AppColors.mainGrey),
                                        )
                                      ],
                                    ),
                                    Text('${listOfCurrency[index].rate}')
                                  ],
                                ),
                              );
                            }),
                      )
                  ],
                ),
              )),
        )
      ),
    );
  }
}
