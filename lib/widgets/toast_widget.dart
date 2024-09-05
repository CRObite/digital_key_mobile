import 'dart:async';

import 'package:flutter/material.dart';

class ToastWidget {
  static void show(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry; // Объявляем переменную до использования

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 40,
        child: _SlideInToast(message: message, onDismissed: () {
          overlayEntry.remove(); // Удаляем entry после завершения анимации
        }),
      ),
    );

    overlay.insert(overlayEntry);
  }
}

class _SlideInToast extends StatefulWidget {
  final String message;
  final VoidCallback onDismissed;

  const _SlideInToast({required this.message, required this.onDismissed});

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
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                widget.message,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}