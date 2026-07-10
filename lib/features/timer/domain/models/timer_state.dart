class TimerState {
  final int seconds;
  final int currentTimer;
  final int counter;
  final int counterLimit;
  final bool isRunning;
  final bool hasFinished;
  final double backgroundOpacity;

  const TimerState({
    required this.seconds,
    required this.currentTimer,
    required this.counter,
    required this.counterLimit,
    required this.isRunning,
    required this.hasFinished,
    required this.backgroundOpacity,
  });

  /// Estado inicial por defecto cuando la aplicación se abre
  factory TimerState.initial() {
    return const TimerState(
      seconds: 0,
      currentTimer: 0,
      counter: 0,
      counterLimit: 0,
      isRunning: false,
      hasFinished: false,
      backgroundOpacity: 0.80, // Totalmente opaco por defecto
    );
  }

  /// Permite modificar una o varias propiedades creando un nuevo objeto estable
  TimerState copyWith({
    int? seconds,
    int? currentTimer,
    int? counter,
    int? counterLimit,
    bool? isRunning,
    bool? hasFinished,
    bool? isExpanded,
    double? backgroundOpacity,
  }) {
    return TimerState(
      seconds: seconds ?? this.seconds,
      currentTimer: currentTimer ?? this.currentTimer,
      counter: counter ?? this.counter,
      counterLimit: counterLimit ?? this.counterLimit,
      isRunning: isRunning ?? this.isRunning,
      hasFinished: hasFinished ?? this.hasFinished,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
    );
  }
}