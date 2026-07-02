class TimerState {
  final int segundos;
  final int contador;
  final bool isRunning;
  final double opacidadFondo;

  const TimerState({
    required this.segundos,
    required this.contador,
    required this.isRunning,
    required this.opacidadFondo,
  });

  /// Estado inicial por defecto cuando la aplicación se abre
  factory TimerState.initial() {
    return const TimerState(
      segundos: 0,
      contador: 0,
      isRunning: false,
      opacidadFondo: 1.0, // Totalmente opaco por defecto
    );
  }

  /// Permite modificar una o varias propiedades creando un nuevo objeto estable
  TimerState copyWith({
    int? segundos,
    int? contador,
    bool? isRunning,
    double? opacidadFondo,
  }) {
    return TimerState(
      segundos: segundos ?? this.segundos,
      contador: contador ?? this.contador,
      isRunning: isRunning ?? this.isRunning,
      opacidadFondo: opacidadFondo ?? this.opacidadFondo,
    );
  }
}