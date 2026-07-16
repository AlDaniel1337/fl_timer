import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import "../../domain/models/timer_state.dart";

class TimerNotifier extends Notifier<TimerState> {
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  TimerState build() {
    // Limpiamos el Timer automáticamente
    // al destruirse el provider (salir de la pantalla), 
    ref.onDispose(() {
      _timer?.cancel();
      _audioPlayer.dispose();
    });
    
    return TimerState.initial();
  }



  //+ Temporizador
  ///: Inicia el flujo del cronómetro sumando un segundo cada ciclo
  void start() {
    
    // Evita duplicar si ya está corriendo
    if (state.isTimerRunning) return; 

    state = state.copyWith(isTimerRunning: true);

    // Inicia un Timer periódico que se ejecuta cada segundo
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.hasTimerFinished) {
        state = state.copyWith(totalTimeInSeconds: state.totalTimeInSeconds + 1);
      }
      else {
        state = state.copyWith(totalTimeInSeconds: state.totalTimeInSeconds - 1);
        
        // Si el tiempo llega a cero, marcamos que ha terminado
        if (state.totalTimeInSeconds <= 0) {
          _reproducirAlarma();
          state = state.copyWith(
            hasTimerFinished: true,
            timerCounter: state.timerCounter + 1
          );
        }
      }
    });
  }



  ///: Pausa el cronómetro deteniendo el Timer activo
  void pause() {
    _timer?.cancel();
    state = state.copyWith(isTimerRunning: false);
  }



  ///: Restablece el temporizador a su estado inicial
  void reset() {
    _timer?.cancel();
    state = TimerState.initial().copyWith(
      // Conservamos la opacidad que eligió el usuario
      backgroundOpacity: state.backgroundOpacity, 
      totalTimeInSeconds: state.currentTimerTime,
      currentTimerTime: state.currentTimerTime,
      timerCounter: state.timerCounter,
    );
  }



  ///: Prepara el temporizador para un nuevo tiempo.
  void updateTiempo({int? horas, int? minutos, int? segundos}) {
    // Calculamos el nuevo total de segundos basándonos en lo que recibimos
    final h = horas ?? (state.totalTimeInSeconds ~/ 3600);
    final m = minutos ?? ((state.totalTimeInSeconds % 3600) ~/ 60);
    final s = segundos ?? (state.totalTimeInSeconds % 60);
    
    state = state.copyWith(currentTimerTime: (h * 3600) + (m * 60) + s);
  }
  //!+ Fin temporizador



  //+ Contador de clics/vueltas
  ///: Incrementa el contador de clics/vueltas en +1
  void incrementCounter() {
    state = state.copyWith(timerCounter: state.timerCounter + 1);
  }


  ///: Decrementa el contador de clics/vueltas en -1, asegurando que no sea negativo
  void decrementCounter() {
    if (state.timerCounter > 0) {
      state = state.copyWith(timerCounter: state.timerCounter - 1);
    }
  }



  ///: Restablece el contador de clics/vueltas a cero
  void resetCounter() {
    state = state.copyWith(timerCounter: 0);
  }
  //!+ Fin contador de clics/vueltas



  //+ Opacidad del fondo
  ///: Actualiza la opacidad del fondo de manera dinámica (ej. desde un Slider)
  void changeOpacity(double newOpacity) {
    state = state.copyWith(backgroundOpacity: newOpacity.clamp(0.0, 1.0));
  }
  //!+ Fin opacidad del fondo



  //+ Alarma sonora
  ///: Reproduce un sonido de alarma cuando el temporizador llega a cero
  Future<void> _reproducirAlarma() async {
    try {
      await _audioPlayer.play(AssetSource('audio/alarm.mp3'));
    } catch (e) {
      debugPrint("Error al reproducir sonido: $e");
    }
  }
  //!+ Fin alarma sonora
}



/// El proveedor global que expondrá este estado a la interfaz de usuario.
/// Usamos .autoDispose para asegurar el cierre de recursos si la vista deja de existir.
final timerProvider = NotifierProvider.autoDispose<TimerNotifier, TimerState>(() {
  return TimerNotifier();
});