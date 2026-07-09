import 'package:flutter/material.dart';

class AppTheme {

  //: Paleta de colores base para el estilo oscuro
  // verde/teal brillante del botón +1 e iniciar
  static const Color primaryTeal = Color(0xFF00BFA5); 
  // El negro más profundo para las tarjetas fijas
  static const Color surfaceCard = Color(0xFF121212); 
  // El blanco limpio para texto e iconos
  static const Color textLight = Colors.white;   
  static const Color timerEndedColor = Colors.cyan;    
  static const Color functionActiveColor =  Color.fromARGB(255, 130, 215, 255);

  /// Genera el color de fondo principal aplicando un nivel de opacidad.
  /// [opacity] debe ser un valor entre 0.0 (completamente transparente) y 1.0 (completamente opaco).
  static Color getBackgroundColor(double opacity) {
    return const Color(0xFF080808).withValues(
      alpha: opacity
    );
  }

  /// Estilo de tema base para la aplicación
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF080808),
      primaryColor: primaryTeal,
      cardColor: surfaceCard,
      
      // Configuración global para los íconos (siempre blancos por defecto)
      iconTheme: const IconThemeData(
        color: textLight,
        size: 24,
      ),

      // Configuración de tipografías y textos en blanco
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textLight,
          fontSize: 48,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
        ),
        titleMedium: TextStyle(
          color: textLight,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: Colors.white70, // Un blanco sutil para textos secundarios
          fontSize: 14,
        ),
      ),
    );
  }
}