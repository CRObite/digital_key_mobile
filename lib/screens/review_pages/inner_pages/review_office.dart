import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/service_operation_status_enum.dart';
import 'package:web_com/config/service_operation_type_enum.dart';
import 'package:web_com/data/repository/service_repository.dart';
import 'package:web_com/domain/pageable.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/shimmer_box.dart';
import 'package:web_com/widgets/status_box.dart';

import '../../../config/app_icons.dart';
import '../../../config/app_shadow.dart';
import '../../../domain/service.dart';
import '../../../utils/custom_exeption.dart';
import '../../../widgets/common_tab_bar.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import 'cabinet_parts/cabinet_part.dart';
import 'cabinet_parts/operation_part.dart';

class ReviewOffice extends StatefulWidget {
  const ReviewOffice({super.key});

  @override
  State<ReviewOffice> createState() => _ReviewOfficeState();
}

class _ReviewOfficeState extends State<ReviewOffice> {

  int selected = 0;
  TextEditingController controller = TextEditingController();

  bool focused = false;


  String? query;
  ServiceOperationStatus? status;
  ServiceOperationType? type;
  int? serviceId;

  final _tabs = const [
    Tab(text: 'Кабинеты'),
    Tab(text: 'Зачисление'),
  ];

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller,
        focused: focused,
        isFocused: (value) {
        setState(() {
          focused = value;
        });
      },),
      body: focused ?
        FilterFocused(
          navigationPageCubit: navigationPageCubit,
          filterChanged: (stat,ty, id){
            setState(() {
              focused = false;
              query = controller.text;
              status = stat;
              type = ty;
              serviceId = id;
            });
          },
          status: status?.description,
          operationType: type?.description,
          serviceId: serviceId,
        ):
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CommonTabBar(tabs: _tabs, onPressed: (value){
                setState(() {
                  selected = value;
                  query = null;
                  status = null;
                  serviceId = null;
                });
              }, selectedValue: selected,),
            ),

            if(selected == 0)
              CabinetPart(navigationPageCubit: navigationPageCubit, query: query, serviceId: serviceId),
            if(selected == 1)
              OperationPart(navigationPageCubit: navigationPageCubit, query: query, status: status,type: type,)
          ],
              ),

      floatingActionButton: selected == 1 ? FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        heroTag: 'addChanges',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: false,
        onPressed: () { context.push('/newOperation'); },
        child: SvgPicture.asset(AppIcons.addContract),
      ) : null,
    );
  }
}




class FilterFocused extends StatefulWidget {
  const FilterFocused({super.key, required this.navigationPageCubit, required this.filterChanged, required this.status, required this.operationType, this.serviceId});

  final NavigationPageCubit navigationPageCubit;

  final Function(ServiceOperationStatus?,ServiceOperationType? type, int?) filterChanged;
  final String? status;
  final String? operationType;
  final int? serviceId;

  @override
  State<FilterFocused> createState() => _FilterFocusedState();
}

class _FilterFocusedState extends State<FilterFocused> {


  List<String> operationTypes = ['Пополнение','Перевод','Списание'];

  String? status;
  String? operationType;
  int? serviceId;

  int page = 0;
  int size = 10;
  int maxPage = 0;
  bool isLoading = false;

  ScrollController scrollController = ScrollController();
  List<Service> listOfService = [];

  @override
  void initState() {

    status = widget.status;
    operationType = widget.operationType;
    serviceId = widget.serviceId;

    getAllService(needLoading: true);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (maxPage > page + 1) {
          page ++;
          getAllService();
        }
      }
    });

    super.initState();
  }

  Future<void> getAllService({bool needLoading = false}) async {

    try{
      setState(() {
        isLoading = true;
      });


      Pageable? pageable = await ServiceRepository().getAllService(context, page, size, '');

      if(pageable != null){
        for(var item in pageable.content){
          listOfService.add(Service.fromJson(item));
        }
        maxPage = pageable.totalPages;
      }
      setState(() {
        isLoading = false;
      });

    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        widget.navigationPageCubit.showMessage(exception.message, false);
      }else{
        rethrow;
      }

      setState(() {
        isLoading = false;
      });
    }
  }


  void resetPage(){
    page = 0;
    listOfService.clear();
    getAllService(needLoading: true);
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Сортировать по статусу',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),

                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: getServiceOperationStatusDescriptions().map((description) {
                    return StatusBox(color: AppColors.secondaryBlueDarker, text: description,selected: status == description,onPressed: (){
                        setState(() {
                          if(status == description){
                            status = '';
                          }else{
                            status = description;
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10,),
                const Text('Операции',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: operationTypes.map((type) {
                    return StatusBox(color: AppColors.secondaryBlueDarker, text: type,selected: operationType == type,onPressed: (){
                      setState(() {
                        if(operationType == type){
                          operationType = '';
                        }else{
                          operationType = type;
                        }
                      });
                    },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10,),
                const Text('Рекламные кабинеты',style: TextStyle(fontSize:16, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                resetPage();
              },
              child: isLoading ?
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 160/40
                ),
                itemCount: 10,
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (BuildContext context, int index) {
                  return const ShimmerBox(width: 200, height: 50);
                },
              ):
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 160/40
                ),
                itemCount: listOfService.length,
                controller: scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (BuildContext context, int index) {


                  if (listOfService.isNotEmpty) {
                    if (index < listOfService.length) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            if(serviceId == listOfService[index].id ){
                              serviceId = null;
                            }else{
                              serviceId = listOfService[index].id;
                            }
                          });
                        },
                        child: Container(
                          decoration:  BoxDecoration(
                              color: serviceId == listOfService[index].id ? AppColors.secondaryBlueDarker : Colors.white,
                              boxShadow: AppShadow.shadow,
                              borderRadius: const BorderRadius.all(Radius.circular(12))
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 18,
                                width: 18,
                                child: listOfService[index].logo?.url != null ? Image.network(listOfService[index].logo!.url!): const SizedBox(),
                              ),
                              const SizedBox(width: 5,),
                              Text(listOfService[index].name ?? '',style: TextStyle(fontWeight: FontWeight.bold, color: serviceId == listOfService[index].id ? Colors.white : AppColors.secondaryGreyDarker),)
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  } else{
                    return Container(margin:const EdgeInsets.only(top: 30) ,child: const Center(child: Text('Нет данных сервисов')),);
                  }

                },
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpandedButton(child: const Text('Применить',style: TextStyle(color: Colors.white),), onPressed: (){

               widget.filterChanged(
                   status!= null && status!.isNotEmpty ? serviceOperationStatusFromDescription(status!): null,
                   operationType!= null && operationType!.isNotEmpty ? serviceOperationTypeFromDescription(operationType): null,
                   serviceId
               );
            }),
          )

        ],
      ),
    );
  }
}
