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

    final TimerPageController controller = TimerPageController(
      ref: ref,
    );


    //: Termporizador: controles / botones
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
        onLongPress: controller.timerNotifier.resetCounter,
        icon: Icons.restore_outlined,
        extraSize: controller.isExpanded ? 8 : 0,
      )
    ];



    //: AppBar: botones
    List<Widget> configButtons = [
      IconButton(
        onPressed: () => controller.toggleUseCounter(),
        icon: Icon(
          Icons.timer_off_outlined,
          color: controller.isCounterEnabled ? Colors.white : AppTheme.functionActiveColor,
          size: 18
        ),
      ),
      IconButton(
        onPressed: () => controller.timerNotifier.switchTimer(controller.currentTimerIndex == 0 ? 1 : 0),
        icon: Icon(
          controller.currentTimerIndex == 0 
            ? Icons.filter_1_outlined 
            : Icons.filter_2_outlined,
          color: controller.currentTimerIndex == 0 ? Colors.white : AppTheme.functionActiveColor,
          size: 18
        ),
      ),
      IconButton(
        onPressed: () => controller.windowNotifier.setShowOpacitySlider(!controller.showOpacitySlider),
        icon: const Icon(Icons.opacity, color: Colors.white, size: 18),
      ),
    ];



    //: Widget principal de la página del temporizador
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Scaffold(
        backgroundColor: AppTheme.getBackgroundColor(controller.backgroundOpacity),
        body: Stack(
          children: [
            //: Modo mini: Contador de vueltas
            if(controller.isMini)
              if(controller.getMaxCount() != null)
                CounterWithLimit(controller: controller)
              else
                CounterWithoutLimit(controller: controller),

            Container(
              padding: controller.isExpanded ? EdgeInsets.zero : EdgeInsets.only(top: 10.0),
              color: AppTheme.getBackgroundColor(0),
              child: Column(
                children: [
                  
                  //: AppBar personalizada con botones de configuración
                  if(controller.isExpanded)
                  CustomAppBar( actions: configButtons ),

                  //: Opacidad: slider para ajustar la opacidad del fondo, solo visible en modo expandido y si el slider está activado
                  if(controller.isExpanded && controller.showOpacitySlider)
                  OpacitySlider(
                    backgroundOpacity: controller.backgroundOpacity,
                    onChanged: (value) => controller.timerNotifier.changeOpacity(value),
                  ),
                  

                  Expanded(
                    child: Column(
                      mainAxisAlignment: controller.isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
                      children: [

                        //: Reloj principal del temporizador
                        ClockDisplay(
                          tiempo: controller.tiempoFormateado,
                          hasFinished: controller.hasTimerFinished,
                          isMini: controller.isMini,
                        ),

                        //: Controles de tiempo (horas, minutos, segundos) solo visibles en modo expandido
                        if(controller.isExpanded)
                        ...[
                          _NewTimeControllers(
                            currentTimer: controller.currentTimerTime, 
                            timerNotifier: controller.timerNotifier
                          ),
                          SizedBox(height: 10.0),
                        ],

                        //: Panel de botones del temporizador
                        TimerControlPanel(
                          panelButtons: panelButtons,
                          isMini: controller.isMini,
                        ),
            
                        if(controller.isExpanded) SizedBox(height: 10.0),
                        
                        //: Panel de control del contador, solo visible si el contador está habilitado
                        if(controller.shouldShowCounterControl())
                        CounterPanel(
                          currentCount: controller.timerCounter,
                          totalCount: controller.getMaxCount() ,
                          onIncrement: () => controller.timerNotifier.incrementCounter(),
                          onDecrement: () => controller.timerNotifier.decrementCounter(),
                          onReset: () => controller.timerNotifier.resetCounter(),
                          onMiniCounterPressed: () => controller.windowNotifier.setUseMiniCounter(!controller.useMiniCounter),
                          isMiniActive: controller.useMiniCounter,
                          showExtraControls: controller.isExpanded,
                          maxCountController: controller.maxCountController,
                          onMaxCountChanged: (value) => controller.updateMaxCount(value),
                        ),
                    
                      ],
                    ),
                  ),              
                ],
              ),
            ),

            //: Botón para cambiar entre los temporizadores disponibles (1 y 2), solo visible si hay un segundo temporizador
            if(controller.shouldShowSecondTimerControl())
            ChangeTimerButton(
              isMini: controller.isMini,
              currentTimerIndex: controller.currentTimerIndex,
              onPressed: () => controller.timerNotifier.switchTimer(controller.currentTimerIndex == 0 ? 1 : 0),
            ),
          ],
        )
      ),
    );
  }
}



///: Controladores de tiempo (horas, minutos, segundos) para el temporizador
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
//!+ Fin widgets auxiliares