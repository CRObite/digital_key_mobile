import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/screens/authorization_pages/registration_page.dart';

class ContractCreatingPage extends StatefulWidget {
  const ContractCreatingPage({super.key});

  @override
  State<ContractCreatingPage> createState() => _ContractCreatingPageState();
}

class _ContractCreatingPageState extends State<ContractCreatingPage> {

  List<String> typeLabels = ['Юридическое лицо','Индивидуальный предприниматель','Физическое лицо', 'Партнер'];
  int selected = 0;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: (){context.pop();}, icon: const Icon(Icons.arrow_back_ios_new, size: 15,)),
              const Text('Новый договор', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: typeLabels.length,
                    itemBuilder: (context, index){
                      return CheckBoxRow(
                        isCircle: true,
                        height: 30,
                          isChecked: index == selected,
                          onPressed: (value){
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Text(typeLabels[index])
                      );
                    }
                ),

                const SizedBox(height: 15,),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.mainOrange.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/ic_warning.svg'),
                      const SizedBox(width: 10,),
                      Flexible(
                        child: Text('Мы используем эту информацию при формировании и отправке закрывающих документов. Проверьте, что вы внесли верные данные',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: AppColors.secondaryGreyDarker,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                Container(

                )



              ],
            ),
          ),




        ],
      ),
    );
  }
}
