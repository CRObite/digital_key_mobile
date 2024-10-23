
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:web_com/config/app_colors.dart';
import 'package:web_com/widgets/custom_drop_down.dart';
import 'package:web_com/widgets/go_back_row.dart';
import 'package:web_com/widgets/titled_field.dart';

import '../../../config/app_box_decoration.dart';
import '../../../domain/contract_data_container.dart';
import '../../../widgets/check_box_row.dart';
import '../../../widgets/double_save_button.dart';
import '../../../widgets/file_picker_container.dart';
import '../../../widgets/search_app_bar.dart';
import '../../navigation_page/navigation_page_cubit/navigation_page_cubit.dart';
import 'contract_creating_cubit/contract_creating_cubit.dart';

class ContractCreatingPage extends StatefulWidget {
  const ContractCreatingPage({super.key});

  @override
  State<ContractCreatingPage> createState() => _ContractCreatingPageState();
}

class _ContractCreatingPageState extends State<ContractCreatingPage> {

  TextEditingController controller = TextEditingController();
  ContractCreatingCubit contractCreatingCubit = ContractCreatingCubit();

  @override
  void initState() {
    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);
    contractCreatingCubit.setClientData(context, navigationPageCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final navigationPageCubit = BlocProvider.of<NavigationPageCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(onMenuButtonPressed: () {
        navigationPageCubit.openDrawer();
      }, isRed: true, searchController: controller,isFocused: (value) {  },),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GoBackRow(title: 'Новый договор'),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocProvider(
                create: (context) => contractCreatingCubit,
                child: ContractCreatingBody(contractCreatingCubit: contractCreatingCubit, navigationPageCubit: navigationPageCubit,),
              )
            ),

          ],
        ),
      ),
    );
  }
}


class ContractCreatingBody extends StatelessWidget {
  const ContractCreatingBody({super.key, required this.contractCreatingCubit, required this.navigationPageCubit});

  final ContractCreatingCubit contractCreatingCubit;
  final NavigationPageCubit navigationPageCubit;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: contractCreatingCubit,
      listener: (context, state) {
        if(state is ContractCreatingSuccess){
          navigationPageCubit.showMessage('Контракт успешно создан', true);
          context.pop(true);
        }
      },
      child: BlocBuilder(
        bloc: contractCreatingCubit,
        builder: (context, state) {

          if(state is ContractCreatingDataLoading){
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.secondaryBlueDarker,
              ),
            );
          }


          if(state is ContractCreatingFetchingSuccess){
            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: contractCreatingCubit.typeLabels.length,
                    itemBuilder: (context, index){
                      return CheckBoxRow(
                          isCircle: true,
                          height: 30,
                          isChecked: index == contractCreatingCubit.selected,
                          onPressed: (value){
                            contractCreatingCubit.selected = index;
                            contractCreatingCubit.fillContainer(context);
                          },
                          child: Text(contractCreatingCubit.typeLabels[index])
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
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.secondaryGreyDarker,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15,),

                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.contractDataContainer.length,
                    itemBuilder: (context,index){
                      return ContractPartContainer(contractDataContainer: state.contractDataContainer[index],);
                    }
                ),

                contractCreatingCubit.selected != 2 ?  CheckBoxRow(onPressed: (value){
                  contractCreatingCubit.selectedFirstCheckBox = value;
                },
                    child: RichText(
                      text: TextSpan(
                        text: 'Соглашаюсь с ', // Regular text
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'условиями договора',
                            style: TextStyle(
                              color: AppColors.secondaryBlueDarker,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('условиями договора clicked');
                              },
                          ),
                          const TextSpan(
                            text: ' *', // Red * symbol
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    )
                ): const SizedBox(),


                CheckBoxRow(onPressed: (value){
                  contractCreatingCubit.selectedSecondCheckBox = value;
                },
                    child: RichText(
                      text: TextSpan(
                        text: 'Разрешаю обработку персональных данных и соглашаюсь с ', // Regular text
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'политикой конфиденциальности',
                            style: TextStyle(
                              color: AppColors.secondaryBlueDarker,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('условиями договора clicked');
                              },
                          ),
                          const TextSpan(
                            text: ' *', // Red * symbol
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                const SizedBox(height: 30,),

                DoubleSaveButton(
                  draftButtonPressed: () {
                    contractCreatingCubit.contractDraftCreate(context, navigationPageCubit);
                  },
                  saveButtonPressed: () {
                    if(contractCreatingCubit.selectedSecondCheckBox && contractCreatingCubit.selectedFirstCheckBox){
                      contractCreatingCubit.contractCreate(context, navigationPageCubit);
                    }else if(contractCreatingCubit.selected == 2 && contractCreatingCubit.selectedSecondCheckBox){
                      contractCreatingCubit.contractCreate(context, navigationPageCubit);
                    }else{
                      navigationPageCubit.showMessage('Необхолдимо дать нужные соглашения', false);
                    }

                  },
                )



              ],
            );
          }


          return const SizedBox();

        },
      ),
    );
  }
}


class ContractPartContainer extends StatelessWidget {
  const ContractPartContainer({super.key, required this.contractDataContainer});

  final ContractDataContainer contractDataContainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: AppBoxDecoration.boxWithShadow,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffF3F4F6),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12)
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Row(
              children: [
                SvgPicture.asset(contractDataContainer.icon),
                const SizedBox(width: 12,),
                Text(contractDataContainer.name, style: const TextStyle(
                    fontWeight: FontWeight.bold
                ),)
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                shrinkWrap: true,

                physics: const NeverScrollableScrollPhysics(),
                itemCount: contractDataContainer.components.length,
                itemBuilder: (context,componentIndex){
                  if(contractDataContainer.components[componentIndex].type == ContainerType.textField){
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TitledField(
                        controller:contractDataContainer.components[componentIndex].controller!,
                        title: contractDataContainer.components[componentIndex].name,
                        type: contractDataContainer.components[componentIndex].filedType!,
                        errorText: contractDataContainer.components[componentIndex].errorText,
                        important: contractDataContainer.components[componentIndex].important,
                      ),
                    );
                  }else if(contractDataContainer.components[componentIndex].type == ContainerType.dropDown){
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: CustomDropDown(
                          selectedItem: contractDataContainer.components[componentIndex].selectedValue,
                          title: contractDataContainer.components[componentIndex].name,
                          important: contractDataContainer.components[componentIndex].important,
                          dropDownList: contractDataContainer.components[componentIndex].dropdownElements ?? [],
                          onSelected: (newValue){
                            contractDataContainer.components[componentIndex].selectedValue = newValue;
                          }
                      ),
                    );
                  }else if(contractDataContainer.components[componentIndex].type == ContainerType.checkBox){
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: CheckBoxRow(
                          isChecked: contractDataContainer.components[componentIndex].selectedValue ?? false,
                          onPressed: (newValue){
                            contractDataContainer.components[componentIndex].selectedValue = newValue;
                          },
                          child: RichText(
                            text: TextSpan(
                              text: contractDataContainer.components[componentIndex].name,
                              style: const TextStyle(fontSize: 12, color: Colors.black),
                              children: contractDataContainer.components[componentIndex].important ? [
                                const TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ] : [],
                            ),
                          )
                      ),
                    );
                  }else if(contractDataContainer.components[componentIndex].type == ContainerType.filePicker){
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: FilePickerContainer(
                        onPressed: (value) async {
                          contractDataContainer.components[componentIndex].selectedValue = value;
                        },
                        title: contractDataContainer.components[componentIndex].name,
                        important: contractDataContainer.components[componentIndex].important,
                        fileName: contractDataContainer.components[componentIndex].selectedValue ,
                        deletePressed: () {
                          contractDataContainer.components[componentIndex].selectedValue = null;
                        },
                      ),
                    );
                  }else{
                    return const SizedBox();
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}
