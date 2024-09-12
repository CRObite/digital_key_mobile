
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile.dart';
import 'package:web_com/widgets/custom_drop_down.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/status_box.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_icons.dart';
import '../../../config/app_shadow.dart';
import '../../../widgets/common_tab_bar.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class FinanceDocuments extends StatefulWidget {
  const FinanceDocuments({super.key});

  @override
  State<FinanceDocuments> createState() => _FinanceDocumentsState();
}

class _FinanceDocumentsState extends State<FinanceDocuments> {

  List<bool> selectedValues = [false,false,false,false,false,false];

  TextEditingController controller =TextEditingController();
  TextEditingController controllerFrom =TextEditingController();
  TextEditingController controllerTo =TextEditingController();

  bool selectingStarted = false;

  final _tabs = const [
    Tab(text: 'Счет'),
    Tab(text: 'ЭСФ'),
    Tab(text: 'АВР'),
  ];

  int selected = 0;

  bool focused = false;

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller, isFocused: (value) {
        setState(() {
          focused = value;
        });
      },),
      body: focused ? FinanceFilter(controllerFrom: controllerFrom, controllerTo: controllerTo,): Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CommonTabBar(tabs: _tabs, onPressed: (value){
              setState(() {
                selected = value;
              });
            }),
          ),

          if(selected == 0)
            Expanded(
              child: ListView.builder(
                  itemCount: selectedValues.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onLongPress: (){
                        if(!selectingStarted){
                          setState(() {
                            selectedValues[index] = !selectedValues[index];
                            selectingStarted = true;
                          });
                        }
                      },
                      onTap: (){
                        if(selectingStarted){
                          setState(() {
                            selectedValues[index] = !selectedValues[index];
                            if(selectedValues.every((element) => element == false)){
                              selectingStarted = false;
                            }
                          });
                        }
                      },
                      child: FinanceCard(type: FinanceCardType.bill, selected: selectedValues[index],),
                    );
                  }
              ),
            ),
          if(selected == 1)
            Expanded(
              child: ListView.builder(
                  itemCount: selectedValues.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context,index){
                    return FinanceCard(type: FinanceCardType.abp, selected: selectedValues[index],);
                  }
              ),
            ),
          if(selected == 2)
            Expanded(
              child: ListView.builder(
                  itemCount: selectedValues.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context,index){
                    return FinanceCard(type: FinanceCardType.contract, selected: selectedValues[index],);
                  }
              ),
            ),

        ],
      ),
      floatingActionButton: selected != 0 ? FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () {  },
        child: SvgPicture.asset(AppIcons.addContract),
      ): selectingStarted ? FloatingActionButton(
        backgroundColor: Colors.red.shade400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: false,
        onPressed: () {  },
        child: SvgPicture.asset(AppIcons.delete, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),),
      ): null,

    );
  }
}

enum FinanceCardType{
  bill, abp, contract
}

class FinanceCard extends StatelessWidget {
  const FinanceCard({super.key, required this.type, required this.selected});

  final FinanceCardType type;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppShadow.shadow,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: selected ? Border.all(width: 1, color: AppColors.mainBlue): null,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatusBox(color: AppColors.mainBlue, text: 'Выставлен'),
                const SizedBox(height: 10,),
                const Text('Счет KZ240000543',style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 15,),
                if(type == FinanceCardType.abp)
                const Row(
                  children: [
                    Expanded(child: DoubleTextColumn(text: 'Договор', text2: '-')),
                    SizedBox(width: 10,),
                    Expanded(child: DoubleTextColumn(text: 'Дата ABP', text2: '08.02.2024')),
                  ],
                ),
                if(type == FinanceCardType.bill)
                const DoubleTextColumn(text: 'Договор', text2: '12242022-СУ_12.12.2022'),
                if(type == FinanceCardType.contract)
                const DoubleTextColumn(text: 'Дата договора', text2: '08.02.2024 00:00'),
                const SizedBox(height: 10,),
                if(type == FinanceCardType.bill)
                const Row(
                  children: [
                    Expanded(child: DoubleTextColumn(text: 'Сумма', text2: '540 000.00 ₸')),
                    SizedBox(width: 10,),
                    Expanded(child: DoubleTextColumn(text: 'Дата выставления', text2: '08.02.2024')),
                  ],
                ),
                if(type == FinanceCardType.abp)
                  const Row(
                    children: [
                      Expanded(child: DoubleTextColumn(text: 'Сумма', text2: '540 000.00 ₸')),
                      SizedBox(width: 10,),
                      Expanded(child: DoubleTextColumn(text: 'Счет на оплату', text2:'-')),
                    ],
                  ),
                if(type == FinanceCardType.contract)
                  const DoubleTextColumn(text: 'Дата окончания', text2: '08.02.2025 00:00'),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                InkWell(
                  onTap: (){},
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xffEBF4FC),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset('assets/icons/ic_download.svg'),
                  ),
                ),
                const SizedBox(height: 10,),
                if(type == FinanceCardType.bill)
                IconButton(onPressed: (){}, icon: SvgPicture.asset('assets/icons/ic_delete.svg'))

              ],
            ),
          ),
        ],
      ),
    );
  }
}


class FinanceFilter extends StatelessWidget {
  const FinanceFilter({super.key, required this.controllerFrom, required this.controllerTo});

  final TextEditingController controllerFrom;
  final TextEditingController controllerTo;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Фильтр', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              CustomDropDown(title: 'Дата выставления', dropDownList: const [], onSelected: (value){}, hint: 'Счет',),
              const SizedBox(height: 10,),
              CustomDropDown(title: 'Договор', dropDownList: const [], onSelected: (value){},hint: 'Счет',),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Flexible(flex: 2,child: TitledField(controller: controllerFrom, title: 'Сумма', type: TextInputType.number, hint:'От',)),
                  const SizedBox(width: 10,),
                  Flexible(flex: 2,child: TitledField(controller: controllerTo, title: '', type: TextInputType.number, hint:'До',)),
                ],
              ),
            ],
          ),

          ExpandedButton(onPressed: (){

          }, child: const Text('Применить',style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }
}
