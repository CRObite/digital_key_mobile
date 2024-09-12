
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_com/config/app_box_decoration.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/widgets/expanded_button.dart';

import '../../widgets/search_app_bar.dart';
import '../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

  TextEditingController controller =TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller, isFocused: (value ) {  },),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Услуги', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 160/200,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  decoration: AppBoxDecoration.boxWithShadow,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('assets/images/vk.png',fit: BoxFit.fill,),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text('Вконтакте', style: GoogleFonts.poppins(color: AppColors.secondaryGreyDarker, fontSize: 16),),
                      const SizedBox(height: 5,),
                      RichText(
                        text: TextSpan(
                          text: 'Бонус',
                          style: const TextStyle(color: Color(0xffD1D5DB)),
                          children: [

                            TextSpan(
                              text: ' 3%',
                              style: TextStyle(color: AppColors.secondaryGreyDarker),
                            ),
                          ],
                        ),
                      ),

                      ExpandedButton(
                          innerPaddingY: 10,
                          onPressed: (){},
                          child: const Text('Подключить',style: TextStyle(color: Colors.white,fontSize: 12),)
                      )
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
