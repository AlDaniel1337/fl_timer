class TimerState {
  final int seconds;
  final int counter;
  final bool isRunning;
  final bool hasFinished;
  final double backgroundOpacity;

  const TimerState({
    required this.seconds,
    required this.counter,
    required this.isRunning,
    required this.hasFinished,
    required this.backgroundOpacity,
  });

  /// Estado inicial por defecto cuando la aplicación se abre
  factory TimerState.initial() {
    return const TimerState(
      seconds: 0,
      counter: 0,
      isRunning: false,
      hasFinished: false,
      backgroundOpacity: 1.0, // Totalmente opaco por defecto
    );
  }

  /// Permite modificar una o varias propiedades creando un nuevo objeto estable
  TimerState copyWith({
    int? seconds,
    int? counter,
    bool? isRunning,
    bool? hasFinished,
    double? backgroundOpacity,
  }) {
    return TimerState(
      seconds: seconds ?? this.seconds,
      counter: counter ?? this.counter,
      isRunning: isRunning ?? this.isRunning,
      hasFinished: hasFinished ?? this.hasFinished,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
    );
  }
}