import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer/core/theme/app_theme.dart';
import 'package:timer/features/timer/presentation/pages/timer.page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // Inicializar el windowManager
  await windowManager.ensureInitialized();
  
  // Configuración de la ventana
  WindowOptions windowOptions = const WindowOptions(
    size: Size(230, 220), // Tamaño de la ventana
    minimumSize: Size(230, 220), // Tamaño mínimo de la ventana
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden, // Ocultar la barra de título
    alwaysOnTop: true, // Mantener la ventana siempre encima
  );
  
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

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
      title: 'Timer App',
      theme: AppTheme.darkTheme,
      home: const TimerPage(),
    );
  }
}
