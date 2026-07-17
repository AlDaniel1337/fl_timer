import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer/core/theme/app_theme.dart';
import 'package:timer/features/timer/domain/models/panel_icon_button.dart';
import 'package:timer/features/timer/presentation/controller/timer_page.controller.dart';
import 'package:timer/features/timer/presentation/pages/components/opacity_slider.dart';
import 'package:timer/features/timer/presentation/providers/timer.provider.dart';
import 'package:timer/features/timer/presentation/widgets/widgets.index.dart';
import 'package:timer/shared/custom_app_bar.dart';

class TimerPage extends ConsumerWidget {
   
  const TimerPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final TimerPageController controller = TimerPageController(ref);



    //: Control del temporizador
    List<PanelIconButton> panelButtons = [
      PanelIconButton(
        onPressed: controller.toggleSize,
        icon: controller.isExpanded ? Icons.fullscreen_exit : Icons.open_in_full,
        extraSize: controller.isExpanded ? 8 : 0,
      ),
      PanelIconButton(
        onPressed: controller.playPauseTimer,
        icon: controller.isTimerRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,        
        extraSize: controller.isExpanded ? 20 : 14,
      ),
      PanelIconButton(
        onPressed: controller.resetTimer,
        icon: Icons.restore_outlined,
        extraSize: controller.isExpanded ? 8 : 0,
      )
    ];



    //: Controles de selección de temporizador (principal o secundario)
    List<Widget> configButtons = [
      IconButton(
        onPressed: () => controller.windowNotifier.setShowOpacitySlider(!controller.showOpacitySlider),
        icon: const Icon(Icons.opacity, color: Colors.white, size: 18),
      ),
      TextButton(
        onPressed: (){}, 
        child: Text(
          'Auxiliar', 
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    ];



    //: Widget principal de la página del temporizador
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Scaffold(
        backgroundColor: AppTheme.getBackgroundColor(controller.backgroundOpacity),
        body: Container(
          color: AppTheme.getBackgroundColor(0),
          child: Column(
            children: [

              if(controller.isExpanded)
              CustomAppBar( actions: configButtons ),

              if(controller.isExpanded && controller.showOpacitySlider)
              OpacitySlider(
                backgroundOpacity: controller.backgroundOpacity,
                onChanged: (value) => controller.timerNotifier.changeOpacity(value),
              ),
              
              Expanded(
                child: Column(
                  mainAxisAlignment: controller.isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
                  children: [
                    ClockDisplay(
                      tiempo: controller.tiempoFormateado,
                      hasFinished: controller.hasTimerFinished,
                      isMini: controller.isMini,
                    ),

                    if(controller.isExpanded)
                    ...[
                      _NewTimeControllers(
                        currentTimer: controller.currentTimerTime, 
                        timerNotifier: controller.timerNotifier
                      ),
                      SizedBox(height: 10.0),
                    ],

                    ControlPanel(
                      panelButtons: panelButtons,
                      isMini: controller.isMini,
                    ),

                    if(controller.isExpanded) SizedBox(height: 10.0),
                    
                    if(!controller.isMini)
                    CounterPanel(
                      currentCount: controller.timerCounter,
                      onIncrement: () => controller.timerNotifier.incrementCounter(),
                      onDecrement: () => controller.timerNotifier.decrementCounter(),
                      onReset: () => controller.timerNotifier.resetCounter(),
                      onMiniCounterPressed: () => controller.windowNotifier.setUseMiniCounter(!controller.useMiniCounter),
                      isMiniActive: controller.useMiniCounter,
                      showExtraControls: controller.isExpanded,
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