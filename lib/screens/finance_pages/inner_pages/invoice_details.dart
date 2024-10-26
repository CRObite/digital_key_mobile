import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/status_box.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../../config/app_box_decoration.dart';
import '../../../domain/invoice.dart';
import '../../../widgets/count_text_row.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import '../../review_pages/inner_pages/review_profile.dart';

class InvoiceDetails extends StatefulWidget {
  const InvoiceDetails({super.key, required this.invoice});

  final Invoice invoice;

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {

  TextEditingController controller = TextEditingController();
  int selected = 0;


  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller,isFocused: (value) {  },),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        context.pop();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: const Icon(Icons.arrow_back_ios_new,size: 15,)),
                          const SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Счет',style: TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis,),
                              Text(widget.invoice.documentNumber ?? '',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 5,),

                  StatusBox(color: AppColors.secondaryBlueDarker, text: 'Сформировать документ')

                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PartColumn(
                  isSelected: selected == 0,
                  title: 'Выписка',
                  onSelected: () {
                    setState(() {
                      selected = 0;
                    });
                  },
                ),
                PartColumn(
                  isSelected: selected == 1,
                  title: 'Услуга',
                  onSelected: () {
                    setState(() {
                      selected = 1;
                    });
                  },
                )
              ],
            ),

            if(selected == 1)
              const ServicePart()

          ],
        ),
      ),
    );
  }
}


class ServicePart extends StatefulWidget {
  const ServicePart({super.key});

  @override
  State<ServicePart> createState() => _ServicePartState();
}

class _ServicePartState extends State<ServicePart> {

  TextEditingController controller = TextEditingController();

  List<ScrollController> scrollControllers = [];

  @override
  void initState() {
    setScroller(5);
    super.initState();
  }


  void setScroller(int count){
    for (int i = 0; i < count; i++) {
      final controller = ScrollController();
      controller.addListener(() => _syncScroll(controller));
      scrollControllers.add(controller);
    }
  }

  void _syncScroll(ScrollController scrolledController) {
    final scrollOffset = scrolledController.hasClients
        ? scrolledController.offset
        : 0.0;

    for (final controller in scrollControllers) {
      if (controller != scrolledController && controller.hasClients && controller.offset != scrollOffset) {
        controller.jumpTo(scrollOffset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        CupertinoContextMenu(
          actions: [
            CupertinoContextMenuAction(
              onPressed: () {
                Navigator.pop(context);
              },
              isDefaultAction: true,
              trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
              child: const Text('Copy'),
            ),
            CupertinoContextMenuAction(
              onPressed: () {
                Navigator.pop(context);
              },
              trailingIcon: CupertinoIcons.share,
              child: const Text('Share'),
            ),
          ],
          child: Material(
            color: Colors.white,
            child: SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width - 40,
              child: Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.38,
                      decoration: const BoxDecoration(
                        color: Color(0xffF9FAFB),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('020325551265', style: TextStyle(fontSize: 12,color: AppColors.secondaryGreyDarker),),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
            
                              SizedBox(width: 18,height: 18,
                                  child: Image.asset('assets/images/vk.png')
                              ),
                              const SizedBox(width: 5,),
                              const Flexible(child: Text('Название аккаунта', style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                            ],
                          )
                        ],
                      )
                  ),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: TitledField(
                        removePadding: true,
                        height: 45,
                        controller: controller,
                        title: 'Введите сумму к пополнению',
                        type: TextInputType.number,
                        needTitle: false,
                      ),
                    ),
                  )
                  
                ],
              ),
            ),
          ),
        ),


        const CountTextRow(count: 1, text: 'Рекламные кабинеты',),

        Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: AppBoxDecoration.boxWithShadow,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context,index) {
                    return SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.38,
                              decoration: const BoxDecoration(
                                color: Color(0xffF9FAFB),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('020325551265', style: TextStyle(fontSize: 12,color: AppColors.secondaryGreyDarker),),
                                  const SizedBox(height: 5,),
                                  Row(
                                    children: [

                                      SizedBox(width: 18,height: 18,
                                          child: Image.asset('assets/images/vk.png')
                                      ),
                                      const SizedBox(width: 5,),
                                      const Flexible(child: Text('Название аккаунта', style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                    ],
                                  )
                                ],
                              )
                          ),

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: TitledField(
                                removePadding: true,
                                height: 45,
                                controller: controller,
                                title: 'Введите сумму к пополнению',
                                type: TextInputType.number,
                                needTitle: false,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
              ),
            )
        ),

        const SizedBox(height: 20,),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: ExpandedButton(
              innerPaddingY: 10,
              child: const Text('Добавить кабинеты',style: TextStyle(color: Colors.white),),
              onPressed: (){}
          ),
        ),
        const CountTextRow(count: 2, text: 'Услуга для счета на оплату',),

        Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: AppBoxDecoration.boxWithShadow,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context,index) {
                    return SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          InkWell(
                            onTap:(){

                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                decoration: const BoxDecoration(
                                  color: Color(0xffF9FAFB),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Услуга', style: TextStyle(fontSize: 12,color: AppColors.secondaryGreyDarker),),
                                    const SizedBox(height: 5,),
                                    const Flexible(child: Text('Пополнение счетa', style: TextStyle(fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                  ],
                                )
                            ),
                          ),

                          Expanded(
                              child: index == scrollControllers.length-1 ? Scrollbar(
                                  controller: scrollControllers[index],
                                  thumbVisibility: true,
                                  child: ScrollableRow(controller: scrollControllers[index],)
                              ) : ScrollableRow(controller: scrollControllers[index],)
                          )
                        ],
                      ),
                    );
                  }
              ),
            )
        ),

        const SizedBox(height: 20,),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: ExpandedButton(
              innerPaddingY: 10,
              child: const Text('Добавить услугу',style: TextStyle(color: Colors.white),),
              onPressed: (){}
          ),
        ),

        const CountTextRow(count: 3, text: 'Подтверждение',),

        Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: AppBoxDecoration.boxWithShadow,
            child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DoubleTextColumn(text: 'Количество кабинетов', text2: '5',big: true,),
                      SizedBox(height: 20,),
                      DoubleTextColumn(text: 'Общая сумма пополнений', text2: '451 578 KZT',big: true),
                      SizedBox(height: 20,),
                      DoubleTextColumn(text: 'Сумма НДС', text2: '457 KZT',big: true),
                      SizedBox(height: 20,),
                      DoubleTextColumn(text: 'Общая сумма пополнений', text2: '451 KZT',big: true),
                    ],
                  ),
                )
            )
        ),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ExpandedButton(
              innerPaddingY: 10,
              child: const Text('Выставить счет',style: TextStyle(color: Colors.white),),
              onPressed: (){}
          ),
        ),

      ],
    );
  }
}





class ScrollableRow extends StatelessWidget {
  const ScrollableRow({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const DoubleTextColumn(text: 'Кол-во', text2: '1,000',gap: 5,),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const DoubleTextColumn(text: 'Ед.изм.', text2: 'Шт',gap: 5,),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: const DoubleTextColumn(text: 'Сумма', text2: '4000',gap: 5,),
          ),

        ],
      ),
    );
  }
}
