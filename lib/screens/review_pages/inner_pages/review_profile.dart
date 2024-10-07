
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_box_decoration.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/data/repository/contract_repository.dart';
import 'package:web_com/domain/contract.dart';
import 'package:web_com/domain/pageable.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile_cubit/review_profile_cubit.dart';
import 'package:web_com/widgets/custom_drop_down.dart';


import 'package:web_com/widgets/shimmer_box.dart';
import 'package:web_com/widgets/status_box.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../../config/app_icons.dart';
import '../../../config/app_texts.dart';
import '../../../config/signer_type_enum.dart';
import '../../../domain/bank.dart';
import '../../../domain/contacts_card_info.dart';
import '../../../domain/currency.dart';
import '../../../domain/position.dart';
import '../../../utils/custom_exeption.dart';
import '../../../widgets/check_box_row.dart';
import '../../../widgets/circle_check.dart';
import '../../../widgets/contract_card.dart';
import '../../../widgets/double_save_button.dart';
import '../../../widgets/file_picker_container.dart';
import '../../../widgets/lazy_drop_down.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';

class ReviewProfile extends StatefulWidget {
  const ReviewProfile({super.key});

  @override
  State<ReviewProfile> createState() => _ReviewProfileState();
}

class _ReviewProfileState extends State<ReviewProfile> {


  final PageController _pageController = PageController();
  TextEditingController controller = TextEditingController();

  ReviewProfileCubit reviewProfileCubit = ReviewProfileCubit();


  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    reviewProfileCubit.getClientData(context);
    super.initState();
  }

  void _scrollToCurrentPosition() {
    double position = reviewProfileCubit.currentPosition * 80.0;
    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  final List<Map<String, dynamic>> sections = [
    {'title': AppTexts.client, 'position': 0},
    {'title': AppTexts.contacts, 'position': 1},
    {'title': 'Адреса', 'position': 2},
    {'title': 'Банковские счета', 'position': 3},
    {'title': 'Подписант', 'position': 4},
    {'title': AppTexts.contract, 'position': 5},
  ];

  void _onItemSelected(int position) {

    reviewProfileCubit.currentPosition = position;

    setState(() {
      _scrollToCurrentPosition();
      _pageController.animateToPage(
        reviewProfileCubit.currentPosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller,isFocused: (value) {  },),
      body: BlocProvider(
        create: (context) => reviewProfileCubit,
        child: BlocListener<ReviewProfileCubit,ReviewProfileState>(
          listener: (context, state) {
          },
          child: BlocBuilder<ReviewProfileCubit,ReviewProfileState>(
            builder: (context,state) {

              if(state is ReviewProfileLoading){
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ShimmerBox(width: 200, height: 30)
                          ),
                          SizedBox(width: 20,),
                          ShimmerBox(width: 100, height: 30)
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerBox(width: 100, height: 30),
                          ShimmerBox(width: 100, height: 30),
                          ShimmerBox(width: 100, height: 30),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            ShimmerBox(width: double.infinity, height: 50),
                            SizedBox(height: 10,),
                            ShimmerBox(width: double.infinity, height: 50),
                            SizedBox(height: 25,),
                          ],
                        ),
                      )
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: ShimmerBox(width: double.infinity, height: 50),
                    )
                  ],
                );
              }

              if(state is ReviewProfileSuccess){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              state.client.name ?? '',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 20,),
                          if(state.client.expiration!= null && state.client.expiration!.daysLeft != null)
                            StatusBox(color: state.client.expiration!.daysLeft! <= 3 ? Colors.red: const Color(0xffEAB308), text: state.client.expiration!.daysLeft! <= 0 ? 'Срок истек':'${AppTexts.daysUntilDelete} ${state.client.expiration!.daysLeft}')

                        ],
                      ),
                    ),

                    SizedBox(
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: sections.map((section) {
                                return PartColumn(
                                  isSelected: reviewProfileCubit.currentPosition == section['position'],
                                  title: section['title'],
                                  onSelected: () => _onItemSelected(section['position']),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),


                    const SizedBox(height: 20),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {

                          reviewProfileCubit.currentPosition = index;
                          setState(() {
                            _scrollToCurrentPosition();
                          });
                        },
                        children: [
                          ClientPart(nameController: reviewProfileCubit.nameController, iinController: reviewProfileCubit.iinController,),

                          ContactPart(
                            listOfInfo: reviewProfileCubit.contactsCardList,
                            deleteContract: (value) => reviewProfileCubit.deleteContact(value),
                            contactPersonChange: (index , value) => reviewProfileCubit.contactPersonChange(index, value),
                            addNew: () => reviewProfileCubit.addContact(),
                          ),

                          AddressPart(
                            realAddressController: reviewProfileCubit.realAddressController,
                            addressController: reviewProfileCubit.addressController,
                          ),

                          BankPart(
                            listOBankInfo: reviewProfileCubit.bankCardList,
                            bankSelected: (index, value) => reviewProfileCubit.selectBank(index, value),
                            currencySelected: (index, value) => reviewProfileCubit.selectBankCurrency(index, value),
                            mainAccountChange: (index , value) => reviewProfileCubit.mainBankAccountChange(index, value),
                            deleteAccount: (index) => reviewProfileCubit.deleteBankAccount(index),
                            navigationPageCubit: navigationPageCubit,
                            addAccount: () => reviewProfileCubit.addBankAccount(),
                          ),

                          SignerPart(
                            nameController: reviewProfileCubit.signerNameController,
                            selectedSignerType: reviewProfileCubit.signer?.type,
                            fileName: reviewProfileCubit.signer?.stampFile?.name,
                            positionList: reviewProfileCubit.listOfPosition,
                            selectedPosition: reviewProfileCubit.signer?.position,
                            positionSelected: (Position value) => reviewProfileCubit.signerPositionSelected(value),
                            signerTypeSelected: (SignerType value) => reviewProfileCubit.signerTypeSelected(value),
                            filePicked: (String value) => reviewProfileCubit.signerSetStampFile(context, value, navigationPageCubit),
                            deleteFile: () => reviewProfileCubit.signerDeleteStampFile(),
                          ),

                          if(state.client.id!= null )
                            ContractPart(clientId: state.client.id!,)
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: DoubleSaveButton(
                        draftButtonPressed: () {
                          reviewProfileCubit.saveDraftData(
                              context,
                              state.client,
                              navigationPageCubit
                          );
                                                    },
                        saveButtonPressed: () {
                          reviewProfileCubit.saveClientChangesData(
                              context,
                              state.client,
                              navigationPageCubit
                          );
                        },
                      ),
                    )
                  ],
                );
              }


              return Container();
            },
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
            style:  TextStyle(
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
  const ClientPart({super.key, required this.nameController, required this.iinController});

  final TextEditingController nameController;
  final TextEditingController iinController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TitledField(controller: nameController, title: AppTexts.counterAgentName, type: TextInputType.text),
          const SizedBox(height: 10,),
          TitledField(controller: iinController, title: AppTexts.iin, type: TextInputType.text),
          const SizedBox(height: 25,),
        ],
      ),
    );
  }
}

class ContactPart extends StatelessWidget {
  const ContactPart({super.key, required this.listOfInfo, required this.deleteContract, required this.contactPersonChange, required this.addNew});

  final List<ContactsCardInfo> listOfInfo;
  final Function(int) deleteContract;
  final Function(int, bool) contactPersonChange;
  final VoidCallback addNew;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: listOfInfo.length,
          itemBuilder: (context, index){

            return Container(
              margin: EdgeInsets.only(bottom: index != listOfInfo.length - 1 ?  10: 80),
              width: double.infinity,
              decoration: AppBoxDecoration.boxWithShadow,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  TitledField(controller: listOfInfo[index].nameController, title: AppTexts.fullName, type: TextInputType.text),
                  const SizedBox(height: 10,),
                  TitledField(controller: listOfInfo[index].phoneController, title: AppTexts.phoneNumber, type: TextInputType.phone),
                  const SizedBox(height: 10,),
                  TitledField(controller: listOfInfo[index].emailController, title: AppTexts.email, type: TextInputType.emailAddress),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: CheckBoxRow(
                          height: 30,
                          isChecked: listOfInfo[index].contactPerson,
                          onPressed: (value) {
                            contactPersonChange(index,value);
                          },
                          child: Text(AppTexts.contactPerson,style: const TextStyle(fontSize: 12),),
                        ),
                      ),

                      IconButton(onPressed: (){deleteContract(index);}, icon: SvgPicture.asset(AppIcons.delete))
                    ],
                  ),
                ],
              ),
            );
          }
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () { addNew(); },
        child: SvgPicture.asset(AppIcons.addContact),
      ),

    );
  }
}

class AddressPart extends StatelessWidget {
  const AddressPart({super.key, required this.realAddressController, required this.addressController});

  final TextEditingController realAddressController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TitledField(controller: addressController, title: 'Юридический адрес', type: TextInputType.text),
          const SizedBox(height: 20,),
          TitledField(controller: realAddressController, title: 'Фактический адрес', type: TextInputType.text),
          CheckBoxRow(
            isChecked: addressController.text == realAddressController.text,
            onPressed: (value) {

            },
            child: const Text('Совпадает с юридическим',style: TextStyle(fontSize: 12),)
          ),

        ],
      ),
    );
  }
}


class BankPart extends StatelessWidget {
  const BankPart({super.key, required this.listOBankInfo, required this.bankSelected, required this.currencySelected, required this.mainAccountChange, required this.deleteAccount, required this.navigationPageCubit, required this.addAccount,});

  final List<BankCardInfo> listOBankInfo;
  final Function(int,Bank) bankSelected;
  final Function(int,Currency) currencySelected;
  final Function(int, bool) mainAccountChange;
  final Function(int) deleteAccount;
  final VoidCallback addAccount;
  final NavigationPageCubit navigationPageCubit;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
        itemCount: listOBankInfo.length,
        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.only(bottom: index != listOBankInfo.length - 1 ?  10: 80),
            width: double.infinity,
            decoration: AppBoxDecoration.boxWithShadow,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                LazyDropDown(
                  navigationPageCubit: navigationPageCubit,
                  selected: (Bank value) {
                    bankSelected(index,value);
                  },
                  currentValue: listOBankInfo[index].selected,
                ),
                const SizedBox(height: 10,),
                TitledField(controller: listOBankInfo[index].bankAccount, title: 'Номер счета', type: TextInputType.text),
                const SizedBox(height: 10,),
                const Text('Валюта',style: TextStyle(fontSize: 12, color: Colors.black),),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                      itemCount: listOBankInfo[index].listOfCurrency.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,currencyIndex){
                        return SizedBox(
                            width:70,
                            child: Row(
                              children: [
                                CircleCheck(checked:listOBankInfo[index].currencySelected != null ? listOBankInfo[index].listOfCurrency[currencyIndex].id == listOBankInfo[index].currencySelected!.id : false, onPressed: (value) {
                                    if(value){
                                      currencySelected(index,listOBankInfo[index].listOfCurrency[currencyIndex]);
                                    }
                                  },
                                ),
                                const SizedBox(width: 10,),
                                Text(listOBankInfo[index].listOfCurrency[currencyIndex].code ?? '',style: const TextStyle(fontSize: 10),)
                              ],
                            )
                        );
                      }
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckBoxRow(
                        height: 30,
                        isChecked: listOBankInfo[index].mainAccount,
                        onPressed: (value) {
                          mainAccountChange(index,value);
                        },
                        child: const Text('Основной счет',style: TextStyle(fontSize: 12),),
                      ),
                    ),

                    IconButton(onPressed: (){deleteAccount(index);}, icon: SvgPicture.asset(AppIcons.delete))
                  ],
                ),
              ],
            ),
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () {
          addAccount();
        },
        child: SvgPicture.asset('assets/icons/ic_add_bank.svg'),
      ),

    );
  }
}


class SignerPart extends StatelessWidget {
  const SignerPart({super.key, required this.nameController, this.selectedSignerType, required this.fileName, required this.positionList, this.selectedPosition, required this.positionSelected, required this.signerTypeSelected, required this.filePicked, required this.deleteFile});

  final TextEditingController nameController;
  final SignerType? selectedSignerType;
  final String? fileName;
  final List<Position> positionList;
  final Position? selectedPosition;
  final Function(Position) positionSelected;
  final Function(SignerType) signerTypeSelected;
  final Function(String) filePicked;
  final VoidCallback deleteFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TitledField(controller: nameController, title: 'ФИО', type: TextInputType.text),
          const SizedBox(height: 10,),
          CustomDropDown(title: 'Должность', dropDownList: positionList.map((position) => position.name).toList(),
            onSelected: (value){
              positionSelected(positionList.firstWhere((position) => position.name == value));
            },
            selectedItem: selectedPosition?.name,
          ),
          const SizedBox(height: 10,),
          CustomDropDown(title: 'На основании', dropDownList: getSignerTypeDescriptions(),
            onSelected: (value){
              signerTypeSelected(getSignerTypeByDescription(value)!);
            },
            selectedItem: selectedSignerType?.description,
          ),
          const SizedBox(height: 10,),
          FilePickerContainer(
            onPressed: (value) async {
              filePicked(value);
            },
            title: 'файл-основание',
            important: true,
            fileName: fileName,
            deletePressed: () {
              deleteFile();
            },
          ),

        ],
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


      Pageable? value =  await ContractRepository.getContractsByClientId(context, widget.clientId, currentPageCount, size);
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
      body: isLoading ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index){
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                  child: const ShimmerBox(width: 500, height: 150)
              );
            }
        )
      ):RefreshIndicator(
        onRefresh: () async {
          resetList();
        },
        child: listOfValue.isNotEmpty ? SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
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

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        mini: true,
        onPressed: () async {
          await context.pushNamed('contractCreatingPage');
          resetList();
        },
        child: SvgPicture.asset(AppIcons.addContract),
      ),
    );
  }
}



class DoubleTextColumn extends StatelessWidget {
  const DoubleTextColumn({super.key, required this.text, required this.text2, this.gap = 0, this.iconPath = '', this.big = false});

  final String text;
  final String text2;
  final double gap;
  final String iconPath;
  final bool big;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style: TextStyle(fontSize: big ? 14 : 11, color: AppColors.mainGrey),),
        SizedBox(height: gap,),

        if(iconPath.isEmpty)
          Text(text2,style: TextStyle(fontSize: big ? 18:12,),),
        if(iconPath.isNotEmpty)
          Row(
            children: [
              SvgPicture.asset(iconPath),
              const SizedBox(width: 5,),
              Flexible(child: Text(text2,style: TextStyle(fontSize:  big ? 18:12, fontWeight: big ? FontWeight.bold: null),)),
            ],
          )
      ],
    );
  }
}
