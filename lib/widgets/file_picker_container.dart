import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_colors.dart';
import '../config/app_icons.dart';

class FilePickerContainer extends StatelessWidget {
  const FilePickerContainer({super.key, required this.onPressed, required this.title, this.errorText, required this.important, this.fileName, required this.deletePressed});

  final VoidCallback onPressed;
  final VoidCallback deletePressed;
  final String title;
  final String? errorText;
  final String? fileName;
  final bool important;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: const TextStyle(fontSize: 12, color: Colors.black), // Base style for the text
            children: important ? [
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
                   onTap: (){onPressed();},
                   child: Row(
                     children: [
                       SvgPicture.asset('assets/icons/ic_download.svg'),
                       const SizedBox(width: 10,),
                       Flexible(
                         child: Text( fileName != null ? fileName! : 'Прикрепить файл', overflow: TextOverflow.ellipsis, maxLines: 1, style: GoogleFonts.poppins(
                           fontSize: 12, color: AppColors.secondaryBlueDarker
                         ),),
                       )
                     ],
                   ),
                 ),
               ),

              fileName!= null ? GestureDetector(
                onTap: (){
                  deletePressed();
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
