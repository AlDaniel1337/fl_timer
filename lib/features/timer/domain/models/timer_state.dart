class TimerState {
  final int totalTimeInSeconds;
  final int currentTimerTime;
  final int timerCounter;
  final int counterLimit;
  final bool isCounterEnabled;
  final bool isTimerRunning;
  final bool hasTimerFinished;
  final double backgroundOpacity;
  final List<int> timesInSeconds;
  final int currentTimerIndex;

  const TimerState({
    required this.totalTimeInSeconds,
    required this.currentTimerTime,
    required this.timerCounter,
    required this.counterLimit,
    required this.isCounterEnabled,
    required this.isTimerRunning,
    required this.hasTimerFinished,
    required this.backgroundOpacity,
    this.timesInSeconds = const [0, 0],
    this.currentTimerIndex = 0,
  });

  /// Estado inicial por defecto cuando la aplicación se abre
  factory TimerState.initial() {
    return const TimerState(
      totalTimeInSeconds: 0,
      currentTimerTime: 0,
      timerCounter: 0,
      counterLimit: 0,
      isCounterEnabled: true,
      isTimerRunning: false,
      hasTimerFinished: false,
      backgroundOpacity: 0.80, // Totalmente opaco por defecto
      timesInSeconds: [0, 0],
      currentTimerIndex: 0,
    );
  }

  /// Permite modificar una o varias propiedades creando un nuevo objeto estable
  TimerState copyWith({
    int? totalTimeInSeconds,
    int? currentTimerTime,
    int? timerCounter,
    int? counterLimit,
    bool? isCounterEnabled,
    bool? isTimerRunning,
    bool? hasTimerFinished,
    double? backgroundOpacity,
    List<int>? timesInSeconds,
    int? currentTimerIndex,
  }) {
    return TimerState(
      totalTimeInSeconds: totalTimeInSeconds ?? this.totalTimeInSeconds,
      currentTimerTime: currentTimerTime ?? this.currentTimerTime,
      timerCounter: timerCounter ?? this.timerCounter,
      counterLimit: counterLimit ?? this.counterLimit,
      isCounterEnabled: isCounterEnabled ?? this.isCounterEnabled,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      hasTimerFinished: hasTimerFinished ?? this.hasTimerFinished,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
      timesInSeconds: timesInSeconds ?? this.timesInSeconds,
      currentTimerIndex: currentTimerIndex ?? this.currentTimerIndex,
    );
  }
}