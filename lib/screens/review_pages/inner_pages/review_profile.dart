
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/config/app_shadow.dart';
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
import '../../../widgets/check_box_row.dart';
import '../../../widgets/contract_card.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class ReviewProfile extends StatefulWidget {
  const ReviewProfile({super.key});

  @override
  State<ReviewProfile> createState() => _ReviewProfileState();
}

class _ReviewProfileState extends State<ReviewProfile> {

  int currentPosition = 0;
  bool _isSwiped = false;
  final PageController _pageController = PageController();
  Client? client;
  ReviewProfileCubit reviewProfileCubit = ReviewProfileCubit();
  List<ContactsCardInfo> contactInfo = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController iinController = TextEditingController();

  @override
  void initState() {
    reviewProfileCubit.getClientData(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller,isFocused: (value ) {  },),
      body: BlocProvider(
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

              navigationPageCubit.showMessage(AppTexts.changesWasSaved, true);
              reviewProfileCubit.getClientData(context);

            }
          },
          child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          nameController.text,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 20,),
                      if(client!= null && client!.expiration!= null && client!.expiration!.daysLeft != null)
                        StatusBox(color: client!.expiration!.daysLeft! <= 3 ? Colors.red: const Color(0xffEAB308), text: '${AppTexts.daysUntilDelete} ${client!.expiration!.daysLeft}')

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      PartColumn(
                        isSelected: currentPosition == 0,
                        title: AppTexts.client,
                        onSelected: () {
                          setState(() {
                            currentPosition = 0;
                            _pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut,);
                          });
                        },
                      ),
                      PartColumn(
                        isSelected: currentPosition == 1,
                        title: AppTexts.contacts,
                        onSelected: () {
                          setState(() {
                            currentPosition = 1;
                            _pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut,);
                          });
                        },
                      ),
                      PartColumn(
                        isSelected: currentPosition == 2,
                        title: AppTexts.contract,
                        onSelected: () {
                          setState(() {
                            currentPosition = 2;
                            _pageController.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut,);
                          });
                        },
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentPosition = index;
                      });
                    },
                    children: [
                      ClientPart(nameController: nameController, iinController: iinController, refresh: () { reviewProfileCubit.getClientData(context); },),
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

                          navigationPageCubit.showMessage('Контакт был удален', true);

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
                                    context,
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
                                    context,
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
      ),
    );
  }
}


class PartColumn extends StatelessWidget {
  const PartColumn({super.key, required this.isSelected, required this.title, required this.onSelected});

  final bool isSelected;
  final String title;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onSelected();
      },
      child: Column(
        children: [
          Text(
            title,
            style:  GoogleFonts.poppins(
              fontSize: 12,
              color: isSelected ? AppColors.secondaryBlueDarker : null,
            ),
          ),


          const SizedBox(height: 5,),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isSelected ? 3 : 0,
            width: isSelected ? MediaQuery.of(context).size.width * 0.08 : 0,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.secondaryBlueDarker : Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ],
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
        getNewData(needLoading: true);
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

  bool isLoading = true;

  Future<void> getNewData({bool needLoading = false}) async {

    if(needLoading){
      setState(() {
        isLoading = true;
      });
    }

    try{
      String url = '${AppEndpoints.address}${AppEndpoints.getAllContracts}';

      Pageable? value =  await ContractRepository.getContractsByClientId(context,url, widget.clientId, currentPageCount, size);
      if(value != null){

        maxPage = value.totalPages;
        List<dynamic> dataList = value.content;
        for(var item in dataList){
          listOfValue.add(Contract.fromJson(item));
        }

        setState(() {
          isLoading  = false;
        });
      }
    }catch(e){

      setState(() {
        isLoading  = false;
      });

      if(e is DioException){
        CustomException exception = CustomException.fromDioException(e);
        print(exception.message);
      }else{
        rethrow;
      }
    }
  }

  void resetList(){
    listOfValue.clear();
    maxPage = 0;
    currentPageCount = 0;

    getNewData(needLoading:  true);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading ? Center(child: CircularProgressIndicator(color: AppColors.mainBlue,),):Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RefreshIndicator(
          onRefresh: () async {
            resetList();
          },
          child: listOfValue.isNotEmpty ? SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
          ): const Center(
            child: Text('Для данного клиента договоры не найдены'),
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
  const DoubleTextColumn({super.key, required this.text, required this.text2, this.gap = 0, this.iconPath = ''});

  final String text;
  final String text2;
  final double gap;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style: TextStyle(fontSize: 11, color: AppColors.mainGrey),),
        SizedBox(height: gap,),

        if(iconPath.isEmpty)
          Text(text2,style: const TextStyle(fontSize: 12),),
        if(iconPath.isNotEmpty)
          Row(
            children: [
              SvgPicture.asset(iconPath),
              const SizedBox(width: 5,),
              Flexible(child: Text(text2,style: const TextStyle(fontSize: 12),)),
            ],
          )
      ],
    );
  }
}
