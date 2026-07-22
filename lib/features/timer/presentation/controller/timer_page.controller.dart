import 'package:flutter/material.dart';
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

  //: Formateo del tiempo en segundos a un formato legible
  late String tiempoFormateado;

  //: Controlador del texto del campo de entrada del contador máximo
  final TextEditingController maxCountController = TextEditingController();

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

    maxCountController.text = ref.watch(timerProvider.select((s) => s.counterLimit.toString()));

    tiempoFormateado = TimeFormatter.formatSeconds(totalTimeInSeconds);
  }



  //+ Funciones
  ///: Cambia el tamaño de la ventana entre expandido y compacto
  void toggleSize() { 
    if(!isExpanded) {
      windowNotifier.setWindowState(WindowSizeState.expanded);
      return;
    }

    if(isExpanded && !useMiniCounter) {
      windowNotifier.setWindowState(
        !isCounterEnabled 
          ? WindowSizeState.compactWithoutCounter 
          : WindowSizeState.compact
      );
    } else if(useMiniCounter) {
      windowNotifier.setWindowState(WindowSizeState.mini);
    }
  }


  ///: Reinicia el temporizador
  void resetTimer() => timerNotifier.reset();
  


  ///: Inicia o pausa el temporizador
  void playPauseTimer() async {
    isTimerRunning ? timerNotifier.pause() : timerNotifier.start();

    if(isExpanded) return;

    if (useMiniCounter) {
      await windowNotifier.setWindowState(WindowSizeState.mini);
      return;
    }
    
    await windowNotifier.setWindowState(WindowSizeState.compact);
    
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

    if(isMini && secondTimerTime != 0) return true;
    if(isExpanded) return false;

    return false;
  }


  ///: Actualizar el número máximo de vueltas/clics del contador
  void updateMaxCount(String value) {
    int? maxCount = int.tryParse(value);
    if(maxCount == null) return;

    timerNotifier.setMaxCount(maxCount);
  }


  ///: Obtener el número máximo de vueltas/clics del contador
  int? getMaxCount() {
    int? maxCount = int.tryParse(maxCountController.text);

    if(maxCount == null) return null;
    if(maxCount <= 0) return null;

    return maxCount;
  }


  ///: Modo mini: mostrar el contador
  String getMiniCounterText() {
    if(!useMiniCounter) return '';

    int? maxCount = getMaxCount();

    if(maxCount == null) return '$timerCounter';
    return '$timerCounter / $maxCount';
  }
  //!+ Fin funciones
}