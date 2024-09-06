import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ToastWidget {
  static void show(BuildContext context, String message,bool isPositive) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry; // Объявляем переменную до использования

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 40,
        child: _SlideInToast(message: message, onDismissed: () {
          overlayEntry.remove(); // Удаляем entry после завершения анимации
        }, isPositive: isPositive,),
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _SlideInToast extends StatefulWidget {
  final String message;
  final VoidCallback onDismissed;
  final bool isPositive;

  const _SlideInToast({required this.message, required this.onDismissed, required this.isPositive});

  @override
  __SlideInToastState createState() => __SlideInToastState();
}

class __SlideInToastState extends State<_SlideInToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Меняем направление анимации: виджет будет выезжать сверху вниз
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Виджет появляется сверху
      end: const Offset(0, 0),    // Финальная позиция в своем месте
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

    // Запускаем таймер на 3 секунды перед скрытием
    Timer(const Duration(seconds: 3), () {
      _controller.reverse().then((value) {
        widget.onDismissed(); // Удаление OverlayEntry после завершения анимации
            });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width - 20,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: widget.isPositive ? const Color(0xffCAF1D8) : const Color(0xffFFD0CE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(widget.isPositive ? 
                'assets/icons/ic_correct.svg':
                'assets/icons/ic_wrong.svg'),
              const SizedBox(width: 8),
              Text(
                widget.message,
                style: TextStyle(color: widget.isPositive ? const Color(0xff1DA750): const Color(0xffD9342B) ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}