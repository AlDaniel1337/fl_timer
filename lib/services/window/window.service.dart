import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:timer/services/window/window.state.dart';
import 'package:window_manager/window_manager.dart';

class WindowService {

  // Tamaño de la ventana en modo compacto y expandido
  static const Size sizeConpact = Size(180, 180);
  static const Size sizeExpanded = Size(220, 270);
  static const Size sizeOpacity  = Size(220, 330);
  static const Size miniSize = Size(140, 100);



  /// Configuración e Inicialización de la ventana
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    
    await windowManager.setMaximizable(false);

    WindowOptions windowOptions = const WindowOptions(
      size: sizeExpanded,
      minimumSize: sizeConpact, 
      maximumSize: sizeExpanded,
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
  static Future<void> resizeWindow(WindowSizeState state, bool? showOpacitySlider) async {
    switch (state) {
      case WindowSizeState.expanded:
        await windowManager.setMinimumSize( showOpacitySlider == true ? sizeOpacity : sizeExpanded);
        await windowManager.setSize(
          showOpacitySlider == true ? sizeOpacity : sizeExpanded, 
          animate: true
        );
        break;
      case WindowSizeState.mini:
        await windowManager.setMinimumSize(miniSize);
        await windowManager.setSize(miniSize, animate: true);
        break;
      case WindowSizeState.compact:
        await windowManager.setMinimumSize(sizeConpact);
        await windowManager.setSize(sizeConpact, animate: true);
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
    await WindowService.resizeWindow(newState, state.showOpacitySlider);
  }

  /// Cambia el estado de la ventana y si debe mostrar el mini contador
  Future<void> setUseMiniCounter(bool useMiniCounter) async {
    state = state.copyWith(
      shouldChangeToMiniCounter: useMiniCounter,
    );
  }

  /// Cambia el estado de la ventana y si debe mostrar el control de opacidad
  Future<void> setShowOpacitySlider(bool show) async {
    state = state.copyWith(
      showOpacitySlider: show,
    );
    await WindowService.resizeWindow(state.windowSizeState, state.showOpacitySlider);
  }
}

// Proveedor global para usar en tus Widgets
final windowProvider = StateNotifierProvider<WindowStateNotifier, WindowState>((ref) {
  return WindowStateNotifier();
});