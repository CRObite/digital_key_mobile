import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


import '../config/app_colors.dart';

class TitledField extends StatefulWidget {
  const TitledField({super.key, required this.controller, required this.title, required this.type, this.errorText, this.important = false, this.hint = '', this.needTitle = true});

  final TextEditingController controller;
  final String title;
  final TextInputType type;
  final String? errorText;
  final bool important;
  final String hint;
  final bool needTitle;

  @override
  State<TitledField> createState() => _TitledFieldState();
}

class _TitledFieldState extends State<TitledField> {
  late FocusNode _focusNode;
  Color _borderColor = AppColors.borderGrey;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _borderColor = _focusNode.hasFocus ? Colors.blue : AppColors.borderGrey;
    });
  }



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {

      print(pickedDate);

      setState(() {
        widget.controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  static MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ### - ## - ##',
    filter: { "#": RegExp(r'[0-9]') },
  );




  @override
  void dispose() {
    _focusNode.unfocus();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.needTitle ?  RichText(
          text: TextSpan(
            text: widget.title,
            style: const TextStyle(fontSize: 12, color: Colors.black),
            children: widget.important ? [
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ] : [],
          ),
        ): const SizedBox(),
        Container(
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              border: Border.all(
                color: _borderColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12))
          ),
          child: widget.type == TextInputType.datetime ? GestureDetector(
            onTap: (){
              _selectDate(context);
            },
            child: AbsorbPointer(
              child: TextFormField(
                focusNode: _focusNode,
                controller: widget.controller,
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide.none,),
                  hintText: widget.hint.isEmpty ? widget.title : widget.hint,
                  hintStyle: TextStyle(fontSize: 12,color: AppColors.mainGrey),
                  suffixIcon: IconButton(
                    splashColor: Colors.transparent,
                    color: AppColors.borderGrey,
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/ic_calendar_outlined.svg'),
                  ),
                ),
              ),
            ),
          ):TextFormField(
            focusNode: _focusNode,
            obscureText: widget.type == TextInputType.visiblePassword ? _obscureText : false,
            inputFormatters: widget.type == TextInputType.phone ? [maskFormatter]:
            widget.type == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly,]:  null,
            keyboardType: widget.type,
            controller: widget.controller,
            style: const TextStyle(fontSize: 12),
            decoration: InputDecoration(
              border: const OutlineInputBorder(borderSide: BorderSide.none,),
              hintText: widget.hint.isEmpty ? widget.title : widget.hint,
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
              ): null ,
            ),
          ),
        ),

        if(widget.errorText != null && widget.errorText!.isNotEmpty)
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
