import 'package:flutter/material.dart';
import 'package:timer/core/theme/app_theme.dart';

class TimerPage extends StatelessWidget {
   
  const TimerPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.getBackgroundColor(0.85),
        child: const Center(
          child: Text(
            '00:04:57', 
            style: TextStyle(color: AppTheme.textLight), // Texto en blanco impecable
          ),
        ),
      )
    );
  }
}