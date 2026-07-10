///: Tamaños de ventana y estado de la ventana
enum WindowSizeState {
  compact,
  expanded,
  mini
}



///: Clase que representa el estado de la ventana, incluyendo su tamaño y si debe cambiar a un mini contador.
class WindowState {

  final WindowSizeState windowSizeState;
  final bool shouldChangeToMiniCounter;
  final bool showOpacitySlider;

  const WindowState({
    required this.windowSizeState,
    required this.shouldChangeToMiniCounter,
    required this.showOpacitySlider,
  });

  /// Estado inicial por defecto cuando la aplicación se abre
  factory WindowState.initial() {
    return const WindowState(
      windowSizeState: WindowSizeState.expanded,
      shouldChangeToMiniCounter: false,
      showOpacitySlider: false,
    );
  }

  /// Permite modificar una o varias propiedades creando un nuevo objeto estable
  WindowState copyWith({
    WindowSizeState? windowSizeState,
    bool? shouldChangeToMiniCounter,
    bool? showOpacitySlider,
  }) {
    return WindowState(
      windowSizeState: windowSizeState ?? this.windowSizeState,
      shouldChangeToMiniCounter: shouldChangeToMiniCounter ?? this.shouldChangeToMiniCounter,
      showOpacitySlider: showOpacitySlider ?? this.showOpacitySlider,
    );
  }
}