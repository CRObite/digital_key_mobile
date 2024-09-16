import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/widgets/custom_drop_down.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/titled_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () { context.pop(); },
          icon: const Icon(Icons.arrow_back_ios_new),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle
                      ),
                    ),
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
              const SizedBox(height: 10,),
              Text('bekzat',style: TextStyle(color: AppColors.secondaryGreyDarker,fontSize: 16),),
              Text('bekzat@gmail.com',style: TextStyle(color: AppColors.mainGrey,fontSize: 12),),
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
                    CustomDropDown(title: 'Должность', dropDownList: const [], onSelected: (value){}),
                    const SizedBox(height: 10,),
                    TitledField(controller: dateController, title: 'Дата рождения', type: TextInputType.datetime),
                    const SizedBox(height: 10,),
                    TitledField(controller: passwordController, title: 'Пароль', type: TextInputType.visiblePassword),
                    TextButton(onPressed: (){}, child: Text('Изменить пароль',style: TextStyle(fontSize: 12,color: AppColors.secondaryBlueDarker),))
                  ],
                ),
              ),
              
              ExpandedButton(child: const Text('Сохранить изменения',style: TextStyle(color: Colors.white),), onPressed: (){})
          
            ],
          ),
        ),
      ),
    );
  }
}
