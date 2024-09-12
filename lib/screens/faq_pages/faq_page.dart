import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_com/config/app_box_decoration.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/widgets/status_box.dart';

import '../../config/app_texts.dart';
import '../../widgets/search_app_bar.dart';
import '../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import '../review_pages/inner_pages/review_profile.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {

  TextEditingController controller =TextEditingController();
  int currentPosition = 0;
  bool opened = false;

  List<String> tabs = ['Google Ads', 'Яндекс Директ', 'Facebook/Instagram'];
  List<String> tags = ['бонус Google', 'остаток бюджета', 'техподдержка','Google Analystics'];
  List<bool> faq = [false,false,false,false,false,false];
  List<bool> tagValue = [false,false,false,false];
  final PageController _pageController = PageController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true,
        searchController: controller, isFocused: (value ) {  },),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Категории',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ),
        
            SizedBox(
              height: 30,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: tabs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: index != tabs.length-1? 40: 0),
                    child: PartColumn(
                      isSelected: currentPosition == index,
                      title: tabs[index],
                      onSelected: () {
                        setState(() {
                          currentPosition = index;
                          // _pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut,);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
        
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Вопрос-ответ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Text('Теги',style: TextStyle(color: AppColors.secondaryGreyDarker),),
            ),
        
            SizedBox(
              height: 30,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                itemCount: tags.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: StatusBox(color: AppColors.mainBlue, text: tags[index], selected: tagValue[index], onPressed: (){
                      setState(() {
                        tagValue[index] = !tagValue[index];
                      });
                    },)
                  );
                },
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
              child: Text('FAQ',style: TextStyle(color: AppColors.secondaryGreyDarker),),
            ),
        
        
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: faq.length,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context,index){
                 return Container(
                   margin: const EdgeInsets.only(bottom: 10),
                   child: NestedListContainer(opened: faq[index], onPressed: () {
                     setState(() {
                       faq[index] = !faq[index];
                     });
                   },
                                   ),
                 );
              }
            )
          ],
        ),
      ),
    );
  }
}


class NestedListContainer extends StatelessWidget {
  const NestedListContainer({super.key, required this.opened, required this.onPressed});

  final bool opened;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            onPressed();
          },
          child: Container(
            decoration: AppBoxDecoration.boxWithShadow,
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Как связать Google Ads и Analytics?',style: TextStyle(color: AppColors.secondaryGreyDarker,fontSize: 12, fontWeight: FontWeight.bold),),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                    opened
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    key: ValueKey<bool>(opened),
                    color: AppColors.mainGrey,
                  ),
                ),
              ],
            ),
          ),
        ),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axis: Axis.vertical,
                child: child,
              ),
            );
          },
          child: opened ? Column(
            key: ValueKey<bool>(opened),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: AppColors.borderGrey.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(12))
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 17),
                child: Text('Для связи Google Ads и Analytics Вам потребуется временно предоставить нам доступ к Вашему аккаунту на уровне “Администратора”.\n\n Для этого Вам необходимо следовать шагам из данной инструкци \n\n Пожалуйста, сообщите нам, когда доступ будет предоставлен, чтобы мы могли проверить его и связать Ваши аккаунты.',
                  style: TextStyle(fontSize: 12, color: AppColors.secondaryGreyDarker),
                ),
              )
            ],
          ) : const SizedBox(key: ValueKey<bool>(false)),
        ),
      ],
    );
  }
}
