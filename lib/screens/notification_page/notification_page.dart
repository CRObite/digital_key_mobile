import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 15,
            )),
        title: Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(right: 40),
              child: const Text('Уведомление',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            )
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context,index){
          return Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: index == 0 ? AppColors.borderGrey : Colors.transparent),
                bottom: BorderSide(width: 1, color: AppColors.borderGrey)
              )
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SvgPicture.asset('assets/icons/ic_warning_outline.svg'),
                ),
                const SizedBox(width: 20,),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Пройдите проверку для показа рекламы финансовых услуг',style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                      Text('Если вы рекламируете в своих аккаунтах финансовые услуги ...',style: TextStyle(color: AppColors.secondaryGreyDarker),),
                      TextButton(onPressed: (){}, child: Text('Посмотреть',style: TextStyle(color: AppColors.secondaryBlueDarker),))
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),

    );
  }
}
