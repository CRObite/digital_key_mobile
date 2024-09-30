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
import '../../widgets/shimmer_box.dart';
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
  int changer = 0;

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
              opened = false;
            });
          }else if(state is NavigationPageMessage) {
            ToastWidget.show(context, state.message,state.positive);
          }else if(state is NavigationPageChanger) {
            setState(() {
              changer = changer == 0 ? 1 : 0;
            });
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
                    changer: changer,
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
  const CustomSideBar({super.key, required this.onSectionPressed, required this.changer});

  final Function(int) onSectionPressed;
  final int changer;

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
  void didUpdateWidget(covariant CustomSideBar oldWidget) {

    super.didUpdateWidget(oldWidget);
    if(widget.changer != oldWidget.changer){
      sideBarCubit.getSideBarData(context);
    }
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
        child: BlocBuilder<SideBarCubit,SideBarState>(
          builder: (context, state) {
            if(state is SideBarLoading){
              return SizedBox(
                height: double.infinity,
                child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          const ShimmerBox(width: double.infinity, height: 50,),

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

                          const ShimmerBox(width: double.infinity, height: 100,),
                        ],
                      ),
                    )),
              );
            }else{
              return SizedBox(
                height: double.infinity,
                child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          if(user != null)
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedSection = -1;
                                });

                                widget.onSectionPressed(11);
                              },
                              child: Row(
                                children: [

                                  AvatarBuilder(id: user!.avatar!= null?  user!.avatar!.id : 0, url: user!.avatar!= null ? user!.avatar!.url: '',),

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
                                                child: listOfCurrency[index].currency.logo!= null ?
                                                SvgPicture.network('http://185.102.74.90:8060/api/files/${Uri.parse(listOfCurrency[index].currency.logo!.url!).pathSegments[2]}/public'): const SizedBox(),
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
              );
            }
          },

        )
      ),
    );
  }
}


class AvatarBuilder extends StatefulWidget {
  const AvatarBuilder({super.key, required this.id, required this.url});

  final int id;
  final String url;

  @override
  State<AvatarBuilder> createState() => _AvatarBuilderState();
}

class _AvatarBuilderState extends State<AvatarBuilder> {

  Uint8List? image;

  @override
  void initState() {

    if(widget.url.isNotEmpty){
      getAvatar();
    }

    super.initState();
  }

  Future<void> getAvatar() async {
    Uint8List? data = await FileRepository.getImageFile(context, widget.url,widget.id);

    setState(() {
      image = data;
    });
  }

  @override
  void didUpdateWidget(covariant AvatarBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.url != widget.url){
      getAvatar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.mainGrey,
      child: image!= null
          ? ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.memory(
              image!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
      ): const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
    );
  }
}
