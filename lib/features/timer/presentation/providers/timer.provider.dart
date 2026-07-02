import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "../../domain/models/timer_state.dart";

class TimerNotifier extends Notifier<TimerState> {
  Timer? _timer;

  @override
  TimerState build() {
    // Limpiamos el Timer automáticamente
    // al destruirse el provider (salir de la pantalla), 
    ref.onDispose(() {
      _timer?.cancel();
    });
    
    return TimerState.initial();
  }

  /// Inicia el flujo del cronómetro sumando un segundo cada ciclo
  void start() {
    
    // Evita duplicar si ya está corriendo
    if (state.isRunning) return; 

    state = state.copyWith(isRunning: true);
    
    // Inicia un Timer periódico que se ejecuta cada segundo
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(segundos: state.segundos + 1);
    });
  }

  /// Pausa el cronómetro deteniendo el Timer activo
  void pause() {
    _timer?.cancel();
    state = state.copyWith(isRunning: false);
  }

  /// Restablece el tiempo y el contador a sus valores iniciales
  void reset() {
    _timer?.cancel();
    state = TimerState.initial().copyWith(
      opacidadFondo: state.opacidadFondo, // Conservamos la opacidad que eligió el usuario
    );
  }

  /// Incrementa el contador de clics/vueltas en +1
  void incrementCounter() {
    state = state.copyWith(contador: state.contador + 1);
  }

  /// Actualiza la opacidad del fondo de manera dinámica (ej. desde un Slider)
  void changeOpacity(double newOpacity) {
    state = state.copyWith(opacidadFondo: newOpacity.clamp(0.0, 1.0));
  }
}



/// El proveedor global que expondrá este estado a la interfaz de usuario.
/// Usamos .autoDispose para asegurar el cierre de recursos si la vista deja de existir.
final timerProvider = NotifierProvider.autoDispose<TimerNotifier, TimerState>(() {
  return TimerNotifier();
});