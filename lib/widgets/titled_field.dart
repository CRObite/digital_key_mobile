import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../config/app_colors.dart';

class TitledField extends StatefulWidget {
  const TitledField({super.key, required this.controller, required this.title, required this.type, this.errorText});

  final TextEditingController controller;
  final String title;
  final TextInputType type;
  final String? errorText;

  @override
  State<TitledField> createState() => _TitledFieldState();
}

class _TitledFieldState extends State<TitledField> {

  bool _obscureText = true;

  static MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ### - ## - ##',
    filter: { "#": RegExp(r'[0-9]') },
  );


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,style: const TextStyle(fontSize: 12),),
        Container(
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.borderGrey,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12))
          ),
          child: TextFormField(
            obscureText: widget.type == TextInputType.visiblePassword ? _obscureText : false,
            inputFormatters: widget.type == TextInputType.phone ? [maskFormatter]:
            widget.type == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly,] :null,
            keyboardType: widget.type,
            controller: widget.controller,
            style: const TextStyle(fontSize: 12),
            decoration: InputDecoration(
              border: const OutlineInputBorder(borderSide: BorderSide.none,),
              hintText: widget.title,
              hintStyle: TextStyle(fontSize: 12,color: AppColors.mainGrey),
              suffixIcon: widget.type == TextInputType.visiblePassword ? IconButton(
                splashColor: Colors.transparent,
                color: AppColors.borderGrey,
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(_obscureText ? Icons.visibility_outlined: Icons.visibility_off_outlined),
              ): null,
            ),
          ),
        ),

        if(widget.errorText != null)
          Column(
            children: [
              const SizedBox(height: 10,),
              Text(widget.errorText!,style: const TextStyle(fontSize: 12, color: Colors.red),),
            ],
          ),
      ],
    );
  }
}
