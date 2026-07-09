import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer/core/theme/app_theme.dart';
import 'package:timer/features/timer/domain/models/panel_icon_button.dart';
import 'package:timer/features/timer/presentation/providers/timer.provider.dart';
import 'package:timer/features/timer/presentation/widgets/widgets.index.dart';
import 'package:timer/services/window/window.service.dart';
import 'package:timer/services/window/window.state.dart';
import 'package:timer/shared/custom_app_bar.dart';
import 'package:timer/utils/time_formatter.dart';

class TimerPage extends ConsumerWidget {
   
  const TimerPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    //: Variables del [estado] de la ventana
    final windowState    = ref.watch(windowProvider);
    final windowNotifier = ref.read(windowProvider.notifier);
    final isExpanded     = windowState.windowSizeState == WindowSizeState.expanded;
    final isMini         = windowState.windowSizeState == WindowSizeState.mini;
    final useMiniCounter = windowState.shouldChangeToMiniCounter;

    //: Variables del [estado] del temporizador
    final timerNotifier  = ref.read(timerProvider.notifier);
    final segundos     = ref.watch(timerProvider.select((s) => s.seconds));
    final currentTimer = ref.watch(timerProvider.select((s) => s.currentTimer));
    final isRunning    = ref.watch(timerProvider.select((s) => s.isRunning));
    final counter      = ref.watch(timerProvider.select((s) => s.counter));
    final hasFinished  = ref.watch(timerProvider.select((s) => s.hasFinished));
    
    // Formateo del tiempo en segundos a un formato legible
    final tiempoFormateado = TimeFormatter.formatSeconds(segundos);

    //: Funciones
    /// Cambia el tamaño de la ventana entre expandido y compacto
    void toggleSize() {
      windowNotifier.setWindowState(
        isExpanded ? WindowSizeState.compact : WindowSizeState.expanded
      );
    }

    /// Reinicia el temporizador
    void resetTimer() {
      timerNotifier.reset();
      if(isExpanded) return;
      windowNotifier.setWindowState(WindowSizeState.compact);
    }

    /// Inicia o pausa el temporizador
    void playPauseTimer() async {
      if (useMiniCounter && !isRunning) {
        await windowNotifier.setWindowState(WindowSizeState.mini);
      } else if (useMiniCounter && isRunning) {
        await windowNotifier.setWindowState(WindowSizeState.compact);
      }

      isRunning ? timerNotifier.pause() : timerNotifier.start();
    }



    //: Botones del panel de control
    List<PanelIconButton> panelButtons = [
      PanelIconButton(
        onPressed: toggleSize,
        icon: isExpanded ? Icons.fullscreen_exit : Icons.open_in_full,
        extraSize: isExpanded ? 8 : 0,
      ),
      PanelIconButton(
        onPressed: playPauseTimer,
        icon: isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,        
        extraSize: isExpanded ? 20 : 14,
      ),
      PanelIconButton(
        onPressed: resetTimer,
        icon: Icons.restore_outlined,
        extraSize: isExpanded ? 8 : 0,
      )
    ];



    //: Widget principal de la página del temporizador
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Scaffold(
        backgroundColor: AppTheme.getBackgroundColor(0.8),
        body: Container(
          color: AppTheme.getBackgroundColor(0),
          child: Column(
            children: [
              if(isExpanded)
              const CustomAppBar(),
              
              Expanded(
                child: Column(
                  mainAxisAlignment: isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
                  children: [
                    ClockDisplay(
                      tiempo: tiempoFormateado,
                      hasFinished: hasFinished,
                      isMini: isMini,
                    ),

                    if(isExpanded)
                    ...[
                      _NewTimeControllers(
                        currentTimer: currentTimer, 
                        timerNotifier: timerNotifier
                      ),
                      SizedBox(height: 10.0),
                    ],

                    ControlPanel(
                      panelButtons: panelButtons,
                      isMini: isMini,
                    ),

                    if(isExpanded) SizedBox(height: 10.0),              
                    
                    if(!isMini)
                    CounterPanel(
                      currentCount: counter,
                      onIncrement: () => timerNotifier.incrementCounter(),
                      onDecrement: () => timerNotifier.decrementCounter(),
                      onReset: () => timerNotifier.resetCounter(),
                      onMiniCounterPressed: () => windowNotifier.setUseMiniCounter(!useMiniCounter),
                      isMiniActive: useMiniCounter,
                      showExtraControls: isExpanded,
                    ),
                
                  ],
                ),
              ),
              
            ],
          ),
        )
      ),
    );
  }
}



class _NewTimeControllers extends StatelessWidget {
  const _NewTimeControllers({
    required this.currentTimer,
    required this.timerNotifier,
  });

  final int currentTimer;
  final TimerNotifier timerNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimeInput(
          value: currentTimer ~/ 3600,
          onChanged: (value){
            timerNotifier.updateTiempo(
              minutos: (currentTimer % 3600) ~/ 60,
              horas: value,
              segundos: currentTimer % 60
            );
          },
        ),
        const SizedBox(width: 8.0),
        TimeInput(
          value: (currentTimer % 3600) ~/ 60,
          onChanged: (value) => timerNotifier.updateTiempo(
            horas: currentTimer ~/ 3600,
            minutos: value,
            segundos: currentTimer % 60
          ),
        ),
        const SizedBox(width: 8.0),
        TimeInput(
          value: currentTimer % 60,
          onChanged: (value) => timerNotifier.updateTiempo(
            horas: currentTimer ~/ 3600,
            minutos: (currentTimer % 3600) ~/ 60,
            segundos: value
          ),
        ),
      ],
    );
  }
}