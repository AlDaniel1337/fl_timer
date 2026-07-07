import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:window_manager/window_manager.dart';

class WindowService {

  // Tamaño de la ventana en modo compacto y expandido
  static const Size sizeCompacto = Size(180, 180);
  static const Size sizeExpandido = Size(220, 270); 



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
  static Future<void> resizeWindow(bool expand) async {
    if (expand) {
      await windowManager.setMinimumSize(sizeExpandido);
      await windowManager.setSize(sizeExpandido, animate: true);
    } else {
      await windowManager.setMinimumSize(sizeCompacto);
      await windowManager.setSize(sizeCompacto, animate: true);
    }
  }
}



/// CONTROLADOR DE ESTADO (RIVERPOD)
/// Maneja si la ventana está expandida (true) o compacta (false)
class WindowStateNotifier extends StateNotifier<bool> {
  WindowStateNotifier() : super(true); // Inicia en modo expandido (true)

  Future<void> toggleSize() async {
    final newState = !state;
    state = newState;
    
    // Ejecuta el cambio físico en la ventana
    await WindowService.resizeWindow(state);
  }
}

// Proveedor global para usar en tus Widgets
final windowProvider = StateNotifierProvider<WindowStateNotifier, bool>((ref) {
  return WindowStateNotifier();
});