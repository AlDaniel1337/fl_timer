import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer/features/timer/presentation/providers/timer.provider.dart';
import 'package:timer/utils/time_formatter.dart';
import 'package:timer/services/window/window.service.dart';
import 'package:timer/services/window/window.state.dart';

class TimerPageController {

  //+ Variables
  //: Variables del [estado] de la ventana
  late WindowState windowState;
  late WindowStateNotifier windowNotifier;
  late bool isExpanded;
  late bool isMini;
  late bool useMiniCounter;
  late bool showOpacitySlider;

  //: Variables del [estado] del temporizador
  late TimerNotifier timerNotifier;
  late int totalTimeInSeconds;
  late int currentTimerTime;
  late bool isTimerRunning;
  late int timerCounter;
  late bool isCounterEnabled;
  late bool hasTimerFinished;
  late double backgroundOpacity;
  late int currentTimerIndex;
  late int secondTimerTime;
  // Formateo del tiempo en segundos a un formato legible
  late String tiempoFormateado;

  final WidgetRef ref;
  //!+ Fin variables



  //: Constructor
  TimerPageController({
    required this.ref,
  }) {
    windowState    = ref.watch(windowProvider);
    windowNotifier = ref.read(windowProvider.notifier);
    isExpanded     = windowState.windowSizeState == WindowSizeState.expanded;
    isMini         = windowState.windowSizeState == WindowSizeState.mini;
    useMiniCounter = windowState.shouldChangeToMiniCounter;
    showOpacitySlider = windowState.showOpacitySlider;

    timerNotifier      = ref.read(timerProvider.notifier);
    totalTimeInSeconds = ref.watch(timerProvider.select((s) => s.totalTimeInSeconds));
    currentTimerTime   = ref.watch(timerProvider.select((s) => s.currentTimerTime));
    isTimerRunning     = ref.watch(timerProvider.select((s) => s.isTimerRunning));
    timerCounter       = ref.watch(timerProvider.select((s) => s.timerCounter));
    isCounterEnabled   = ref.watch(timerProvider.select((s) => s.isCounterEnabled));
    hasTimerFinished   = ref.watch(timerProvider.select((s) => s.hasTimerFinished));
    backgroundOpacity  = ref.watch(timerProvider.select((s) => s.backgroundOpacity));
    currentTimerIndex  = ref.watch(timerProvider.select((s) => s.currentTimerIndex));
    secondTimerTime    = ref.watch(timerProvider.select((s) => s.timesInSeconds[1]));

    tiempoFormateado = TimeFormatter.formatSeconds(totalTimeInSeconds);
  }



  //+ Funciones
  ///: Cambia el tamaño de la ventana entre expandido y compacto
  void toggleSize() {
    windowNotifier.setWindowState(
      isExpanded 
      ? !isCounterEnabled 
        ? WindowSizeState.compactWithoutCounter 
        : WindowSizeState.compact
      : WindowSizeState.expanded,
    );
  }


  ///: Reinicia el temporizador
  void resetTimer() {
    timerNotifier.reset();
    if(isExpanded) return;
    windowNotifier.setWindowState(WindowSizeState.compact);
  }


  ///: Inicia o pausa el temporizador
  void playPauseTimer() async {
    isTimerRunning ? timerNotifier.pause() : timerNotifier.start();

    if(isExpanded) return;

    if (useMiniCounter && !isTimerRunning) {
      await windowNotifier.setWindowState(WindowSizeState.mini);
    } else if (useMiniCounter && isTimerRunning) {
      await windowNotifier.setWindowState(WindowSizeState.compact);
    }
  }


  ///: Cambia el temporizador seleccionado (1, 2)
  void switchTimer(int timerNumber) => timerNotifier.switchTimer(timerNumber);
  


  ///: Activa o desactiva el uso del contador de clics/vueltas
  void toggleUseCounter() => timerNotifier.toggleUseCounter();


  ///: Mostrat u ocultar el control del contador
  bool shouldShowCounterControl() {

    if(isMini) return false;
    if(!isCounterEnabled && !isExpanded) return false;

    return true;
  }


  ///: Mostrar u ocultar el control del segundo temporizador
  bool shouldShowSecondTimerControl() {
    if(isMini) return false;
    if(isExpanded) return false;

    if(secondTimerTime == 0) return false;

    return true;
  }
  //!+ Fin funciones
}