import 'package:flutter/material.dart';
import 'package:timer/core/theme/app_theme.dart';

class ChangeTimerButton extends StatelessWidget {
   
  final VoidCallback? onPressed;
  final int currentTimerIndex;
  final bool isMini;

  const ChangeTimerButton({
    super.key,
    this.onPressed,
    required this.currentTimerIndex,
    this.isMini = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: isMini ? -5 : 2,
      right: 3,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          currentTimerIndex == 0 
            ? Icons.filter_1_outlined 
            : Icons.filter_2_outlined,
          color: currentTimerIndex == 0 ? Colors.white : AppTheme.functionActiveColor,
          size: isMini ? 10 : 14
        ),
      ),
    );
  }
}