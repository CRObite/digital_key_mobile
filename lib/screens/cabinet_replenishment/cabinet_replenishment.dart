
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../config/app_box_decoration.dart';
import '../../config/app_icons.dart';

class CabinetReplenishment extends StatefulWidget {
  const CabinetReplenishment({super.key});

  @override
  State<CabinetReplenishment> createState() => _CabinetReplenishmentState();
}

class _CabinetReplenishmentState extends State<CabinetReplenishment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () { context.pop(); },
          icon: const Icon(Icons.arrow_back_ios_new,size: 20,),
        ),
        title: Align(
            alignment: Alignment.center,
            child: Container(
                margin: const EdgeInsets.only(right: 40),
                child: const Text('Пополнить кабинеты', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
            )
        ),
        backgroundColor: Colors.white,
      ),

      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [

            SizedBox(
                height: 5,
                child: Row(
                  children: [
                    Expanded(child: ProgressPanel(isDone: true)),
                    SizedBox(width: 20),
                    Expanded(child: ProgressPanel(isDone: false)),
                    SizedBox(width: 20),
                    Expanded(child: ProgressPanel(isDone: false)),
                  ],
                )
            ),

            SizedBox(height: 20,),
            
            FirstPart()

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () {},
        child: SvgPicture.asset('assets/icons/ic_add_cabinet.svg'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
        child: ExpandedButton(onPressed: (){}, child: const Text('Далее', style: TextStyle(color: Colors.white),)),
      ),

    );
  }
}


class ProgressPanel extends StatelessWidget {
  const ProgressPanel({super.key, required this.isDone});

  final bool isDone;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: isDone ? AppColors.secondaryBlueDarker : AppColors.borderGrey,
      ),

    );
  }
}

class FirstPart extends StatefulWidget {
  const FirstPart({super.key});

  @override
  State<FirstPart> createState() => _FirstPartState();
}

class _FirstPartState extends State<FirstPart> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: AppColors.secondaryBlueDarker,
                shape: BoxShape.circle
              ),
              child: const Center(child: Text('1', style: TextStyle(color: Colors.white),)),
            ),
            
            const SizedBox(width: 10,),
            
            const Text('Рекламные кабинеты',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
          ],
        ),

        const SizedBox(height: 15,),

        Container(
            width: double.infinity,
            decoration: AppBoxDecoration.boxWithShadow,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context,index){
                    return SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap:(){
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xffF9FAFB),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('020325551265', style: TextStyle(fontSize: 10),),
                                      const SizedBox(height: 5,),
                                      Row(
                                        children: [

                                          SizedBox(width: 18,height: 18,
                                            child: Image.asset('assets/images/vk.png'),
                                          ),
                                          const SizedBox(width: 5,),
                                          const Flexible(child: Text('Название аккаунта', style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                            ),
                          ),

                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TitledField(controller: controller, title: 'Введите сумму к пополнению', type: TextInputType.number,needTitle: false,),
                            ),
                          )

                        ],
                      ),
                    );
                  }
              ),
            )
        ),

      ],
    );
  }
}


