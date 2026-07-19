import 'package:flutter/material.dart';
import 'package:timer/core/theme/app_theme.dart';

class ChangeTimerButton extends StatelessWidget {
   
  final VoidCallback? onPressed;
  final int currentTimerIndex;

  const ChangeTimerButton({
    super.key,
    this.onPressed,
    required this.currentTimerIndex,
  });
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 3,
      left: 3,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          currentTimerIndex == 0 
            ? Icons.filter_1_outlined 
            : Icons.filter_2_outlined,
          color: currentTimerIndex == 0 ? Colors.white : AppTheme.functionActiveColor,
          size: 14
        ),
      ),
    );
  }
}