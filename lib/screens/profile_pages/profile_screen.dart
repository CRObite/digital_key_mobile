
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/data/local/shared_preferences_operator.dart';
import 'package:web_com/screens/navigation_page/navigation_page.dart';
import 'package:web_com/screens/navigation_page/side_bar_cubit/side_bar_cubit.dart';
import 'package:web_com/screens/profile_pages/profile_screen_cubit/profile_screen_cubit.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/toast_widget.dart';
import '../../widgets/shimmer_box.dart';
import '../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController controller = TextEditingController();
  ProfileScreenCubit profileScreenCubit = ProfileScreenCubit();

  @override
  void initState() {
    profileScreenCubit.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () { navigationPageCubit.openDrawer(); },
          icon: SvgPicture.asset('assets/icons/ic_menu.svg'),
        ),
        title: Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(right: 40),
                child: const Text('Данные пользователя', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
            )
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocProvider(
        create: (context) => profileScreenCubit,
        child: BlocListener<ProfileScreenCubit,ProfileScreenState>(
          listener: (context,state) {
            if(state is ProfileScreenError){
              ToastWidget.show(context, state.errorText, true);
            }
          },
          child: BlocBuilder<ProfileScreenCubit,ProfileScreenState>(
            builder: (context,state) {

              if(state is ProfileScreenLoading){
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Expanded(
                        child: Column(
                          children: [
                            ShimmerBox(
                              width: double.infinity,
                              height: 100,
                            ),
                            SizedBox(height: 20,),
                            ShimmerBox(
                              width: double.infinity,
                              height: 100,
                            ),
                          ],
                        ),
                      ),

                      ExpandedButton(
                          child: const Text('Выйти',style: TextStyle(color: Colors.white),),
                          onPressed: (){
                          }
                      )
                    ],
                  ),
                );
              }else if(state is ProfileScreenSuccess){
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: AppColors.borderGrey, width: 1),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: AvatarBuilder(id: state.user.avatar != null? state.user.avatar!.id: 0, url: state.user.avatar != null ? state.user.avatar!.url : '',),
                                      ),
                                      const SizedBox(width: 10,),
                                      Flexible(child: Text(state.user.name ?? '',maxLines: 1,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.secondaryGreyDarker),)),
                                      const SizedBox(width: 10,),
                                      IconButton(onPressed: () async {
                                        await context.pushNamed('profileEdit');

                                        profileScreenCubit.getUserData(context);
                                        navigationPageCubit.callChanger();

                                      }, icon: SvgPicture.asset('assets/icons/ic_edit_outline.svg'))
                                    ],
                                  ),
                                  const SizedBox(height: 25,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.25,
                                        child: ExpandedButton(
                                          onPressed: () { context.pushNamed('cabinetReplenishment'); },
                                          innerPaddingY: 9,
                                          round: 6,
                                          child: const Text('Пополнить',style: TextStyle(color: Colors.white,fontSize: 12),),
                                        ),
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                    text: '5 645 546',
                                                    style: TextStyle(color: Colors.black)),
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
                                                    style: TextStyle(color: Colors.black)),
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

                                ],
                              ),
                            ),

                            const SizedBox(height: 20,),

                            state.client.accountManager!= null ? Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(color: AppColors.borderGrey, width: 1),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Данные менеджера',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Менеджер',style: TextStyle(fontSize: 12,color: AppColors.mainGrey),),
                                      Text(state.client.accountManager?.name ?? '',style: TextStyle(fontSize: 12,color: AppColors.secondaryGreyDarker),),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Email',style: TextStyle(fontSize: 12,color: AppColors.mainGrey),),
                                      Text(state.client.accountManager?.email ?? '',style: TextStyle(fontSize: 12,color: AppColors.secondaryGreyDarker),),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Телефон',style: TextStyle(fontSize: 12,color: AppColors.mainGrey),),
                                      Text(state.client.accountManager?.mobile ?? '',style: TextStyle(fontSize: 12,color: AppColors.secondaryGreyDarker),),
                                    ],
                                  ),
                                ],
                              ),
                            ): const SizedBox(),
                          ],
                        ),
                      ),

                      ExpandedButton(
                          child: const Text('Выйти',style: TextStyle(color: Colors.white),),
                          onPressed: (){
                            SharedPreferencesOperator.clearCurrentUser();
                            context.goNamed('loginPage');
                          }
                      )
                    ],
                  ),
                );
              }else{
                return const SizedBox();
              }
            },
          ),
        )
      )
    );
  }
}
