class TimerState {
  final int totalTimeInSeconds;
  final int currentTimerTime;
  final int timerCounter;
  final int counterLimit;
  final bool isTimerRunning;
  final bool hasTimerFinished;
  final double backgroundOpacity;

  const TimerState({
    required this.totalTimeInSeconds,
    required this.currentTimerTime,
    required this.timerCounter,
    required this.counterLimit,
    required this.isTimerRunning,
    required this.hasTimerFinished,
    required this.backgroundOpacity,
  });

  /// Estado inicial por defecto cuando la aplicación se abre
  factory TimerState.initial() {
    return const TimerState(
      totalTimeInSeconds: 0,
      currentTimerTime: 0,
      timerCounter: 0,
      counterLimit: 0,
      isTimerRunning: false,
      hasTimerFinished: false,
      backgroundOpacity: 0.80, // Totalmente opaco por defecto
    );
  }

  /// Permite modificar una o varias propiedades creando un nuevo objeto estable
  TimerState copyWith({
    int? totalTimeInSeconds,
    int? currentTimerTime,
    int? timerCounter,
    int? counterLimit,
    bool? isTimerRunning,
    bool? hasTimerFinished,
    double? backgroundOpacity,
  }) {
    return TimerState(
      totalTimeInSeconds: totalTimeInSeconds ?? this.totalTimeInSeconds,
      currentTimerTime: currentTimerTime ?? this.currentTimerTime,
      timerCounter: timerCounter ?? this.timerCounter,
      counterLimit: counterLimit ?? this.counterLimit,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      hasTimerFinished: hasTimerFinished ?? this.hasTimerFinished,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
    );
  }
}