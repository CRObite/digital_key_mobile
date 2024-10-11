
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile_cubit/review_profile_cubit.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile_parts/address_part.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile_parts/bank_part.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile_parts/client_part.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile_parts/contact_part.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile_parts/contract_part.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile_parts/document_part.dart';
import 'package:web_com/screens/review_pages/inner_pages/review_profile_parts/signer_part.dart';
import 'package:web_com/widgets/shimmer_box.dart';
import 'package:web_com/widgets/status_box.dart';

import '../../../config/app_texts.dart';
import '../../../config/signer_type_enum.dart';
import '../../../domain/position.dart';
import '../../../widgets/double_save_button.dart';
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
    {'title': 'Разрешительные документы', 'position': 5},
    {'title': AppTexts.contract, 'position': 6},
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


  bool getErrors(int position, Map<String,dynamic> fieldErrors){
    switch(position){
      case 0:
        if(fieldErrors['name'] != null || fieldErrors['bin_iin'] != null){
          return true;
        }else{
          return false;
        }
      case 2:
        if(fieldErrors['addresses']?['0']?['full_address'] != null || fieldErrors['addresses']?['1']?['full_address'] != null){
          return true;
        }else{
          return false;
        }

      default:
        return false;
    }
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
                            width: MediaQuery.of(context).size.width * 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: sections.map((section) {
                                return PartColumn(
                                  isSelected: reviewProfileCubit.currentPosition == section['position'],
                                  title: section['title'],
                                  onSelected: () => _onItemSelected(section['position']),
                                  hasError: state.fieldErrors != null ? getErrors(section['position'],state.fieldErrors!): false,
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

                          ClientPart(
                            nameController: reviewProfileCubit.nameController,
                            iinController: reviewProfileCubit.iinController,
                            nameFieldError: state.fieldErrors?['name'] ?? '',
                            iinFieldError: state.fieldErrors?['bin_iin'] ?? '',
                          ),

                          ContactPart(
                            listOfInfo: reviewProfileCubit.contactsCardList,
                            deleteContract: (value) => reviewProfileCubit.deleteContact(value,state.client),
                            contactPersonChange: (index , value) => reviewProfileCubit.contactPersonChange(index, value),
                            addNew: () => reviewProfileCubit.addContact(state.client),
                          ),

                          AddressPart(
                            realAddressController: reviewProfileCubit.realAddressController,
                            addressController: reviewProfileCubit.addressController,
                            realAddressError: state.fieldErrors?['addresses']?['0']?['full_address'] ?? '',
                            addressError: state.fieldErrors?['addresses']?['1']?['full_address'] ?? '',
                          ),

                          BankPart(
                            listOBankInfo: reviewProfileCubit.bankCardList,
                            bankSelected: (index, value) => reviewProfileCubit.selectBank(index, value),
                            currencySelected: (index, value) => reviewProfileCubit.selectBankCurrency(index, value,state.client),
                            mainAccountChange: (index , value) => reviewProfileCubit.mainBankAccountChange(index, value),
                            deleteAccount: (index) => reviewProfileCubit.deleteBankAccount(index,state.client),
                            navigationPageCubit: navigationPageCubit,
                            addAccount: () => reviewProfileCubit.addBankAccount(state.client),
                          ),

                          SignerPart(
                            nameController: reviewProfileCubit.signerNameController,
                            selectedSignerType: reviewProfileCubit.signer?.type,
                            fileName: reviewProfileCubit.signer?.stampFile?.originalName,
                            positionList: reviewProfileCubit.listOfPosition,
                            selectedPosition: reviewProfileCubit.signer?.position,
                            positionSelected: (Position value) => reviewProfileCubit.signerPositionSelected(value),
                            signerTypeSelected: (SignerType value) => reviewProfileCubit.signerTypeSelected(value),
                            filePicked: (String value) => {reviewProfileCubit.stampFilePath = value},
                            deleteFile: () => reviewProfileCubit.signerDeleteStampFile(),
                          ),

                          DocumentPart(
                              govFileName: state.client.stateRegistrationCertificate?.originalName,
                              requisiteFileNames: state.client.requisites?.originalName,
                              orderFileName: state.client.order?.originalName,
                              ndsFileName:  state.client.vatCertificate?.originalName,
                              filePicked: (index,value){reviewProfileCubit.permits[index] = value;}
                          ),

                          if(state.client.id!= null )
                            ContractPart(clientId: state.client.id!,)
                        ],
                      ),
                    ),

                    reviewProfileCubit.currentPosition != 6 ? Padding(
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
                    ): const SizedBox()
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
  const PartColumn({super.key, required this.isSelected, required this.title, required this.onSelected, this.hasError = false});

  final bool isSelected;
  final String title;
  final VoidCallback onSelected;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onSelected();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color:hasError ?  Colors.red.withOpacity(0.3): null,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
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
