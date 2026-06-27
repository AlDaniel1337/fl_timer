import 'package:flutter/material.dart';
import 'package:timer/core/theme/app_theme.dart';
import 'package:timer/features/timer/presentation/pages/timer.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      theme: AppTheme.darkTheme,
      home: const TimerPage(),
    );
  }
}
