import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer/core/theme/app_theme.dart';
import 'package:timer/features/timer/presentation/pages/timer.page.dart';
import 'package:timer/services/window.service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar el windowManager
  await WindowService.initialize();

  runApp(
    ProviderScope(child: const MyApp())
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timer App',
      theme: AppTheme.darkTheme,
      home: const TimerPage(),
    );
  }
}
