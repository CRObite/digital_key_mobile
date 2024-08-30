
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/app_shadow.dart';
import 'package:web_com/config/client_enum.dart';
import 'package:web_com/data/repository/contract_repository.dart';
import 'package:web_com/domain/client.dart';
import 'package:web_com/domain/contract.dart';
import 'package:web_com/domain/pageable.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile_cubit/review_profile_cubit.dart';
import 'package:web_com/widgets/expanded_button.dart';
import 'package:web_com/widgets/status_box.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../../config/app_endpoints.dart';
import '../../../config/app_icons.dart';
import '../../../config/app_texts.dart';
import '../../../config/app_toast.dart';
import '../../../domain/contacts_card_info.dart';
import '../../../utils/custom_exeption.dart';
import '../../../widgets/contract_card.dart';
import '../../authorization_pages/registration_page.dart';

class ReviewProfile extends StatefulWidget {
  const ReviewProfile({super.key});

  @override
  State<ReviewProfile> createState() => _ReviewProfileState();
}

class _ReviewProfileState extends State<ReviewProfile> {

  int currentPosition = 0;
  bool _isSwiped = false;
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  Client? client;
  ReviewProfileCubit reviewProfileCubit = ReviewProfileCubit();
  List<ContactsCardInfo> contactInfo = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController iinController = TextEditingController();

  @override
  void initState() {
    reviewProfileCubit.getClientData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => reviewProfileCubit,
      child: BlocListener<ReviewProfileCubit,ReviewProfileState>(
        listener: (context, state) {
          if(state is ReviewProfileSuccess){
            nameController.text = state.client.name ?? '';
            iinController.text = state.client.binIin ?? '';

            contactInfo = reviewProfileCubit.setContactInfo(state.client);

            setState(() {
              client = state.client;
            });

          }else if(state is ReviewProfileDraftSet){
            AppToast.showToast('Изменения были сохранены');
            reviewProfileCubit.getClientData();
          }
        },
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameController.text,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        if(client!= null && client!.status!= null)
                          StatusBox(color: AppColors.mainBlue, text: client!.status!.description),
                        const SizedBox(width: 10,),
                        if(client!= null && client!.expiration!= null && client!.expiration!.daysLeft != null)
                          StatusBox(color: const Color(0xffEAB308), text: '${AppTexts.daysUntilDelete} ${client!.expiration!.daysLeft}')
                      ],
                    )

                  ],
                ),
              ),

              SizedBox(
                height: 50,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final isSelected = currentPosition == index;

                    return AnimatedPadding(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(vertical: isSelected ? 0 : 5),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            currentPosition = index;
                            _scrollController.animateTo(
                              index * MediaQuery.of(context).size.width * 0.6,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                            _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut,);
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.only(right: index != 2 ? 10 : 0),
                          width: isSelected ? MediaQuery.of(context).size.width * 0.35 : MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                              color: isSelected ? AppColors.secondaryBlueDarker : AppColors.mainBlue,
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              boxShadow: AppShadow.shadow
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSelected ? 14 : 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                            child: Align( alignment:  Alignment.centerLeft,child: Text(
                                index == 0 ? AppTexts.client :
                                index == 1 ? AppTexts.contacts:
                                AppTexts.contract
                            )
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPosition = index;
                      _scrollController.animateTo(
                        index * MediaQuery.of(context).size.width * 0.6,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                  children: [
                    ClientPart(nameController: nameController, iinController: iinController, refresh: () { reviewProfileCubit.getClientData(); },),
                    ContactPart(
                      carInfo: contactInfo,
                      checkBoxPressed: (value) {
                        setState(() {
                          contactInfo[value].contactPerson = !contactInfo[value].contactPerson;
                        });
                      },
                      addNewPressed: () {
                        setState(() {
                          contactInfo.addAll(reviewProfileCubit.setContactInfo(null));
                        });
                      },
                      deletePressed: (value) {
                        setState(() {
                          contactInfo.removeAt(value);
                        });

                        AppToast.showToast('Контакт был удален');

                      },
                    ),
                    client != null && client!.id!= null ? ContractPart(clientId: client!.id!,): const SizedBox()
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: AppShadow.shadow,
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: InkWell(
                          onTap: () {
                            if(client!= null ){
                              reviewProfileCubit.saveDraftData(
                                  client!,
                                  nameController.text,
                                  iinController.text,
                                  reviewProfileCubit.getContactFromCard(contactInfo)
                              );
                            }

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                AppTexts.saveDraft,
                                style: TextStyle(color: AppColors.secondaryBlueDarker),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: _isSwiped
                            ? MediaQuery.of(context).size.width * 0.45
                            : MediaQuery.of(context).size.width,
                        child: ExpandedButton(
                          innerPaddingY: 0,
                          onPressed: () {
                            if(client!= null ){
                              reviewProfileCubit.saveClientChangesData(
                                  client!,
                                  nameController.text,
                                  iinController.text,
                                  reviewProfileCubit.getContactFromCard(contactInfo)
                              );
                            }
                          },
                          child: Row(
                            children: [
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  AppTexts.saveEdit,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _isSwiped = !_isSwiped;
                                    });
                                  },
                                  icon: Icon(
                                    _isSwiped
                                        ? Icons.arrow_forward_ios
                                        : Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}



class ClientPart extends StatelessWidget {
  const ClientPart({super.key, required this.nameController, required this.iinController,required this.refresh});

  final TextEditingController nameController;
  final TextEditingController iinController;
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RefreshIndicator(
        onRefresh: () async { refresh(); },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              TitledField(controller: nameController, title: AppTexts.counterAgentName, type: TextInputType.text),
              const SizedBox(height: 10,),
              TitledField(controller: iinController, title: AppTexts.iin, type: TextInputType.text),
              const SizedBox(height: 25,),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactPart extends StatelessWidget {
  const ContactPart({super.key, required this.carInfo, required this.checkBoxPressed, required this.addNewPressed, required this.deletePressed});

  final List<ContactsCardInfo> carInfo;
  final Function(int) checkBoxPressed;
  final VoidCallback addNewPressed;
  final Function(int) deletePressed;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            itemCount: carInfo.length,
            itemBuilder: (context, index){

              return Container(
                margin: EdgeInsets.only(bottom: index != carInfo.length - 1 ?  10: 80),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.borderGrey),
                    borderRadius: const BorderRadius.all(Radius.circular(12))
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    TitledField(controller: carInfo[index].nameController, title: AppTexts.fullName, type: TextInputType.text),
                    const SizedBox(height: 10,),
                    TitledField(controller: carInfo[index].phoneController, title: AppTexts.phoneNumber, type: TextInputType.phone),
                    const SizedBox(height: 10,),
                    TitledField(controller: carInfo[index].emailController, title: AppTexts.email, type: TextInputType.emailAddress),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: CheckBoxRow(
                            height: 30,
                            isChecked: carInfo[index].contactPerson,
                            onPressed: (value) {
                              checkBoxPressed(index);
                            },
                            child: Text(AppTexts.contactPerson,style: const TextStyle(fontSize: 12),),
                          ),
                        ),

                        IconButton(onPressed: (){deletePressed(index);}, icon: SvgPicture.asset(AppIcons.delete))
                      ],
                    ),
                  ],
                ),
              );
            }
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () { addNewPressed(); },
        child: SvgPicture.asset(AppIcons.addContact),
      ),

    );
  }
}

class ContractPart extends StatefulWidget {
  const ContractPart({super.key, required this.clientId});

  final int clientId;

  @override
  State<ContractPart> createState() => _ContractPartState();
}

class _ContractPartState extends State<ContractPart> {

  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();

    getNewData();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        getNewData();
      }
    });
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  List<Contract> listOfValue = [];
  int maxPage = 0;
  int currentPageCount = 0;
  int size = 10;


  Future<void> getNewData() async {
    try{
      String url = '${AppEndpoints.address}${AppEndpoints.getAllContracts}';

      Pageable? value =  await ContractRepository.getContractsByClientId(url, widget.clientId, currentPageCount, size);
      if(value != null){

        maxPage = value.totalPages;
        List<dynamic> listOfValue = value.content;
        for(var item in listOfValue){
          listOfValue.add(Contract.fromJson(item));
        }

      }
    }catch(e){
      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        print(exception.message);
      }else{
        rethrow;
      }
    }
  }

  void resetList(){
    listOfValue = [];
    maxPage = 0;
    currentPageCount = 1;

    getNewData();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RefreshIndicator(
          onRefresh: () async {
            resetList();
          },
          child: ListView.builder(
            controller: scrollController,
            itemCount: listOfValue.length + 1,
            itemBuilder: (context, index){

              if (listOfValue.isNotEmpty) {
                if (index < listOfValue.length) {
                  return ContractCard(index: index, onDeletePressed: () {  }, contract: listOfValue[index],);
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: maxPage - 1 <= currentPageCount
                              ? Text(listOfValue.length < size ? '' : 'Больше нет данных')
                              : CircularProgressIndicator(color: AppColors.mainBlue),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  );
                }
              } else {
                return const SizedBox();
              }
            }
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () { context.goNamed('contractCreatingPage'); },
        child: SvgPicture.asset(AppIcons.addContract),
      ),
    );
  }
}



class DoubleTextColumn extends StatelessWidget {
  const DoubleTextColumn({super.key, required this.text, required this.text2});

  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style: TextStyle(fontSize: 12, color: AppColors.mainGrey),),
        Text(text2,style: const TextStyle(fontSize: 12),),
      ],
    );
  }
}
