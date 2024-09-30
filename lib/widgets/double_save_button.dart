import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../config/app_shadow.dart';
import '../config/app_texts.dart';
import 'expanded_button.dart';

class DoubleSaveButton extends StatefulWidget {
  const DoubleSaveButton({super.key, required this.draftButtonPressed, required this.saveButtonPressed, this.draftText, this.saveText});

  final VoidCallback draftButtonPressed;
  final VoidCallback saveButtonPressed;
  final String? draftText;
  final String? saveText;

  @override
  State<DoubleSaveButton> createState() => _DoubleSaveButtonState();
}

class _DoubleSaveButtonState extends State<DoubleSaveButton> {

  bool _isSwiped = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                widget.draftButtonPressed();
                setState(() {
                  _isSwiped = false;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.draftText ?? AppTexts.saveDraft,
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
                widget.saveButtonPressed();
              },
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      widget.saveText ?? AppTexts.saveEdit,
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
    );
  }
}
