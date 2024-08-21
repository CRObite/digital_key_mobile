
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';

import '../../config/app_icons.dart';
import '../../config/app_texts.dart';
import '../../widgets/blue_button.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  List<Map<String, dynamic>> messages = [
    {'id': 0,'name': 'Digital Key Bot' ,'message': 'Если Ваш запрос связан с рекламной системой, пожалуйста, уточните ID рекламного аккаунта и опишите как можно подробнее, чем мы можем вам помочь - это ускорит обработку запроса'},
    {'id': 1,'name': 'Oquway' ,'message': 'Добрый день!'},
    {'id': 1,'name': 'Oquway' ,'message': 'а мы тут дизайн сделали! сейчас фотки скину'},
  ];

  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEBF4FC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff51A2D9),
                  Color(0xff66B2E6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 10,top: 10),
                  child: BlueButton(onPressed: () { context.pop(); }, iconPath: AppIcons.back,)
              ),
              centerTitle: true,
              titleTextStyle: const TextStyle(color: Colors.white,fontSize: 16),
              title: Text(AppTexts.chatText),
              actions: [
                Container(
                    margin: const EdgeInsets.only(right: 20, bottom: 10,top: 10),
                    child: BlueButton(onPressed: () {  }, iconPath: AppIcons.sound,)
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: messages.length,
              itemBuilder: (context,index) {
                return MessageBox(message: messages[index]);
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30),
            child: Container(
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100))
              ),
              padding: const EdgeInsets.symmetric(horizontal:16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      style: const TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        border: const OutlineInputBorder(borderSide: BorderSide.none,),
                        hintText: AppTexts.search,
                        hintStyle: TextStyle(fontSize: 12,color: AppColors.mainGrey),
                      ),
                    ),
                  ),
                  const SizedBox(width:5),
                  Row(
                    children: [
                      SvgPicture.asset(AppIcons.emoji),
                      const SizedBox(width:5),
                      SvgPicture.asset(AppIcons.share),
                      const SizedBox(width:5),
                      SvgPicture.asset(AppIcons.micro),
                    ],
                  )
                ],
              )
            ),
          )
        ],
      )
    );
  }


}


class MessageBox extends StatelessWidget {
  const MessageBox({super.key, required this.message});

  final Map<String, dynamic> message;

  @override
  Widget build(BuildContext context) {

    if(message['id'] == 1){
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              width: 8,
            ),
            Message(message: message['message'], name: message['name'], time:'${DateTime.now().hour}:${DateTime.now().minute}',),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 28,
              height: 28,
              child: CircleAvatar(
                child: Image.network('https://pereborom.ru/wp-content/uploads/2019/03/chernyj-voron-taby-1024x431.jpg',fit: BoxFit.fill,),
              ),
            ),
          ],
        ),
      );
    }else{
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: CircleAvatar(
                child: Image.network('https://pereborom.ru/wp-content/uploads/2019/03/chernyj-voron-taby-1024x431.jpg',fit: BoxFit.fill,),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Message(message: message['message'], name: message['name'], time: '${DateTime.now().hour}:${DateTime.now().minute}',),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      );
    }
  }
}


class Message extends StatelessWidget {
  const Message({super.key, required this.message, required this.name, required this.time});

  final String message;
  final String name;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6))
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    time,
                    style: TextStyle(fontSize: 12, color: AppColors.mainGrey),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}
