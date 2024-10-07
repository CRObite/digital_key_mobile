import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_com/data/repository/file_repository.dart';

import '../config/app_colors.dart';
import '../config/app_icons.dart';
import '../data/local/file_picker_helper.dart';

class FilePickerContainer extends StatefulWidget {
  const FilePickerContainer({super.key, required this.onPressed, required this.title, this.errorText, required this.important, this.fileName, required this.deletePressed});

  final Function(String) onPressed;
  final VoidCallback deletePressed;
  final String title;
  final String? errorText;
  final String? fileName;
  final bool important;

  @override
  State<FilePickerContainer> createState() => _FilePickerContainerState();
}

class _FilePickerContainerState extends State<FilePickerContainer> {


  String? file;
  String? errorText;

  @override
  void initState() {
    file = widget.fileName;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FilePickerContainer oldWidget) {
    if(oldWidget.errorText != widget.errorText){
      setState(() {
        errorText = widget.errorText;
      });
    }
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: widget.title,
            style: const TextStyle(fontSize: 12, color: Colors.black), // Base style for the text
            children: widget.important ? [
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ] : [],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.borderGrey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12))
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Flexible(
                 flex: 2,
                 child: InkWell(
                   onTap: () async {
                     String pickedFile = await FileRepository.pickFile();


                     setState(() {
                       file = pickedFile;
                     });

                     widget.onPressed(pickedFile);

                   },
                   child: Row(
                     children: [
                       SvgPicture.asset('assets/icons/ic_download.svg'),
                       const SizedBox(width: 10,),
                       Flexible(
                         child: Text( file != null ? file! : 'Прикрепить файл', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(
                           fontSize: 12, color: AppColors.secondaryBlueDarker
                         ),),
                       )
                     ],
                   ),
                 ),
               ),

              file!= null ? GestureDetector(
                onTap: (){
                  setState(() {
                    file = null;
                  });
                  widget.deletePressed();
                },
                  child: SvgPicture.asset(AppIcons.delete)
              ) : const SizedBox(width: 20,)

            ],
          )
        ),

        if(errorText != null)
          Column(
            children: [
              const SizedBox(height: 10,),
              Text(errorText!,style: const TextStyle(fontSize: 12, color: Colors.red),),
            ],
          ),
      ],
    );
  }
}
