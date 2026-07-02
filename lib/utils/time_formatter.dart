class TimeFormatter {

  /// Transforma una cantidad total de segundos en un formato de texto legible [HH:MM:SS].
  /// 
  /// Ejemplo: 
  /// `formatSeconds(297)` devolverá `"00:04:57"`
  static String formatSeconds(int totalSeconds) {

    if (totalSeconds < 0) return "00:00:00";

    final int horas    = totalSeconds ~/ 3600;
    final int minutos  = (totalSeconds % 3600) ~/ 60;
    final int segundos = totalSeconds % 60;

    // Convertimos cada unidad a String asegurando que siempre tengan 2 dígitos (ej: "04" en lugar de "4")
    final String horasStr    = horas.toString().padLeft(2, '0');
    final String minutosStr  = minutos.toString().padLeft(2, '0');
    final String segundosStr = segundos.toString().padLeft(2, '0');

    return "$horasStr:$minutosStr:$segundosStr";
  }
}