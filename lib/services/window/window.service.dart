import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:timer/services/window/window.state.dart';
import 'package:window_manager/window_manager.dart';

class WindowService {

  // Tamaño de la ventana en modo compacto y expandido
  static const Size sizeCompacto = Size(180, 180);
  static const Size sizeExpandido = Size(220, 270);
  static const Size miniSize = Size(140, 100);



  /// Configuración e Inicialización de la ventana
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    
    await windowManager.setMaximizable(false);

    WindowOptions windowOptions = const WindowOptions(
      size: sizeExpandido,
      minimumSize: sizeCompacto, 
      maximumSize: sizeExpandido,
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      alwaysOnTop: true,
      title: 'Timer',
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setMaximizable(false);
      await windowManager.setAsFrameless();
      await windowManager.show();
      await windowManager.focus();
    });
  }



  /// Método interno para alternar el tamaño de la ventana
  static Future<void> resizeWindow(WindowSizeState state) async {
    switch (state) {
      case WindowSizeState.expanded:
        await windowManager.setMinimumSize(sizeExpandido);
        await windowManager.setSize(sizeExpandido, animate: true);
        break;
      case WindowSizeState.mini:
        await windowManager.setMinimumSize(miniSize);
        await windowManager.setSize(miniSize, animate: true);
        break;
      case WindowSizeState.compact:
        await windowManager.setMinimumSize(sizeCompacto);
        await windowManager.setSize(sizeCompacto, animate: true);
        break;
    }
  }
}



/// CONTROLADOR DE ESTADO (RIVERPOD)
/// Maneja si la ventana está expandida, compacta o en modo mini.
class WindowStateNotifier extends StateNotifier<WindowState> {
  WindowStateNotifier() : super(WindowState.initial()); // Inicia en modo expandido

  /// Cambia el estado de la ventana
  Future<void> setWindowState(WindowSizeState newState) async {
    state = state.copyWith(windowSizeState: newState);
    await WindowService.resizeWindow(newState);
  }

  /// Cambia el estado de la ventana y si debe mostrar el mini contador
  Future<void> setUseMiniCounter(bool useMiniCounter) async {
    state = state.copyWith(
      shouldChangeToMiniCounter: useMiniCounter,
    );
  }
}

// Proveedor global para usar en tus Widgets
final windowProvider = StateNotifierProvider<WindowStateNotifier, WindowState>((ref) {
  return WindowStateNotifier();
});