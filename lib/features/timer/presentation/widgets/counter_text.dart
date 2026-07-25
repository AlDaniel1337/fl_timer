import 'package:flutter/material.dart';
import 'package:timer/features/timer/presentation/controller/timer_page.controller.dart';

///: Texto que muestra el contador de vueltas/clics
class CounterText extends StatelessWidget {
  const CounterText({
    super.key,
    required this.controller,
    this.fontSize = 18.0,
  });

  final TimerPageController controller;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      controller.getMiniCounterText(),
      style: TextStyle(
        fontSize: fontSize,
        color: const Color.fromARGB(150, 255, 255, 255),
        fontWeight: FontWeight.bold
      ),
    );
  }
}