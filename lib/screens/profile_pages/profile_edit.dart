import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/app_endpoints.dart';
import 'package:web_com/config/app_toast.dart';
import 'package:web_com/data/repository/auth_repository.dart';
import 'package:web_com/data/repository/file_repository.dart';
import 'package:web_com/screens/profile_pages/profile_screen_cubit/profile_screen_cubit.dart';
import 'package:web_com/widgets/custom_drop_down.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/shimmer_box.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../domain/user.dart';
import '../../widgets/toast_widget.dart';
import '../navigation_page/navigation_page.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ProfileScreenCubit profileScreenCubit = ProfileScreenCubit();
  User? user;


  @override
  void initState() {
    profileScreenCubit.getUserData(context);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dateController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () { context.pop(true); },
          icon: const Icon(Icons.arrow_back_ios_new,size: 20,),
        ),
        title: Align(
            alignment: Alignment.center,
            child: Container(
                margin: const EdgeInsets.only(right: 40),
                child: const Text('Редактировать профиль', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
            )
        ),
        backgroundColor: Colors.white,
      ),
      body:  BlocProvider(
          create: (context) => profileScreenCubit,
          child: BlocListener<ProfileScreenCubit,ProfileScreenState>(
            listener: (context,state) {
              if(state is ProfileScreenError){
                ToastWidget.show(context, state.errorText, true);
              }

              if(state is ProfileScreenSuccess){
                setState(() {
                  user = state.user;
                  nameController.text = state.user.name ?? '';
                  emailController.text = state.user.email ?? '';
                  phoneController.text = state.user.mobile ?? '';
                  dateController.text = state.user.birthDay ?? '';
                });
              }

              if(state is ProfileScreenEditSuccess){
                ToastWidget.show(context, 'Изменения успешно сохранены', true);
              }
            },
            child: BlocBuilder<ProfileScreenCubit,ProfileScreenState>(
              builder: (context,state) {

                if(state is ProfileScreenLoading){
                  return const Padding(
                    padding: EdgeInsets.only(right: 20.0,left: 20,bottom: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ShimmerBox(width: 80, height: 150),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerBox(width: double.infinity, height: 60),
                                SizedBox(height: 10,),
                                ShimmerBox(width: double.infinity, height: 60),
                                SizedBox(height: 10,),
                                ShimmerBox(width: double.infinity, height: 60),
                                SizedBox(height: 10,),
                                ShimmerBox(width: double.infinity, height: 60),
                                SizedBox(height: 10,),
                                ShimmerBox(width: double.infinity, height: 60),
                                ShimmerBox(width: 100, height: 40),
                              ],
                            ),
                          ),
                          ShimmerBox(width: double.infinity, height: 70),
                        ],
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {

                            String? imagePath = await FileRepository.pickFile();

                            profileScreenCubit.setNewAvatar(context, user!, imagePath);

                          },
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Stack(
                              children: [
                                user != null ? SizedBox(  width: 100,
                                    height: 100,child: AvatarBuilder(id: user!.avatar!= null? user!.avatar!.id: 0, url: user!.avatar!= null ? user!.avatar!.url: '',)) : const SizedBox(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.mainBlue,
                                          shape: BoxShape.circle,
                                          border: Border.all(width: 1,color: Colors.white)
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: SvgPicture.asset(
                                        'assets/icons/ic_edit_outline.svg',
                                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(nameController.text,style: TextStyle(color: AppColors.secondaryGreyDarker,fontSize: 16),),
                        Text(emailController.text,style: TextStyle(color: AppColors.mainGrey,fontSize: 12),),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitledField(controller: nameController, title: 'Имя', type: TextInputType.name),
                              const SizedBox(height: 10,),
                              TitledField(controller: emailController, title: 'Email', type: TextInputType.emailAddress),
                              const SizedBox(height: 10,),
                              TitledField(controller: phoneController, title: 'Телефон', type: TextInputType.phone),
                              const SizedBox(height: 10,),
                              TitledField(controller: dateController, title: 'Дата рождения', type: TextInputType.datetime),
                              TextButton(onPressed: (){_displayBottom(context);}, child: Text('Изменить пароль',style: TextStyle(fontSize: 12,color: AppColors.secondaryBlueDarker),))
                            ],
                          ),
                        ),

                        ExpandedButton(child: const Text('Сохранить изменения',style: TextStyle(color: Colors.white),), onPressed: (){
                          profileScreenCubit.updateUser(context, user!, nameController.text, emailController.text, phoneController.text, dateController.text);
                        })

                      ],
                    ),
                  ),
                );
              },
            ),
          )
      )
    );
  }


  void _displayBottom(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController confirmController = TextEditingController();


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BottomSheet(
              passwordController: passwordController,
              currentPasswordController: currentPasswordController,
              confirmController: confirmController, context: context,
            )
          ),
        );
      },
    );
  }
}


class BottomSheet extends StatefulWidget {
  const BottomSheet({
    super.key,
    required this.passwordController,
    required this.currentPasswordController,
    required this.confirmController, required this.context
  });

  final TextEditingController passwordController;
  final TextEditingController currentPasswordController;
  final TextEditingController confirmController;
  final BuildContext context;

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {

  String errorCurrent = '';
  String errorNew = '';
  String errorConfirm = '';

  Future<void> setNewPassword() async {



    try{
      bool value = await AuthRepository.resetPassword(
          context,
          widget.currentPasswordController.text,
          widget.passwordController.text,
          widget.confirmController.text
      );

      if(value){

        context.pop();

        ToastWidget.show(widget.context, 'Пароль успешно был изменен', true);
      }
    }catch(e){
      if(e is DioException) {
        if(e.response!= null && e.response!.data['field_errors']!= null){
          setState(() {
            errorCurrent = e.response!.data['field_errors']['old_password'] ?? '';
            errorNew = e.response!.data['field_errors']['new_password'] ?? '';
            errorConfirm = e.response!.data['field_errors']['confirm_password'] ?? '';
          });
        }

      }else{
        rethrow;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Изменить пароль', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        const SizedBox(height: 20,),
        TitledField(controller: widget.currentPasswordController, title: 'Текущий пароль', type: TextInputType.visiblePassword, errorText: errorCurrent,),
        const SizedBox(height: 10,),
        TitledField(controller: widget.passwordController, title: 'Новый пароль', type: TextInputType.visiblePassword, errorText: errorNew,),
        const SizedBox(height: 10,),
        TitledField(controller: widget.confirmController, title: 'Подтвердите новый пароль', type: TextInputType.visiblePassword,errorText: errorConfirm),
        const SizedBox(height: 20,),
        ExpandedButton(child: const Text('Сохранить изменения',style: TextStyle(color: Colors.white),), onPressed: (){setNewPassword();})
      ],
    );
  }
}



