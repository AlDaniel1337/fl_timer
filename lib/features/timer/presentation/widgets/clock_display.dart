import 'package:flutter/material.dart';
import 'package:timer/constants/app_sizes.dart';
import 'package:timer/core/theme/app_theme.dart';
import 'package:window_manager/window_manager.dart';

class ClockDisplay extends StatelessWidget {

  final String tiempo;
  final bool hasFinished;
  final bool isMini;
   
  const ClockDisplay({
    super.key,
    required this.tiempo,
    this.hasFinished = false,
    this.isMini = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {},
      child: DragToMoveArea(
        child: Text(
          tiempo, 
          style: TextStyle(
            color: !hasFinished ? AppTheme.textLight : AppTheme.timerEndedColor,
            fontSize: isMini ? AppTextSize.large : AppTextSize.big,
            fontWeight: FontWeight.w500
            ),
        ),
      ),
    );
  }
}