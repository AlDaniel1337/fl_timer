import 'package:flutter/material.dart';
import 'package:timer/features/timer/presentation/controller/timer_page.controller.dart';
import 'package:timer/features/timer/presentation/widgets/counter_text.dart';

///: Contenedor izquierdo para el contador de vueltas/clics en modo mini
class CounterWithLimit extends StatelessWidget {
  const CounterWithLimit({
    super.key,
    required this.controller,
  });

  final TimerPageController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 15,
      child: CounterText(controller: controller),
    );
  }
}