import 'package:flutter/material.dart';
import 'package:timer/constants/app_sizes.dart';
import 'package:timer/core/theme/app_theme.dart';

class CounterPanel extends StatelessWidget {

  final int currentCount;
  final int? totalCount;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onReset;
  final VoidCallback? onMiniCounterPressed;
  final bool isMiniActive;
  final bool showExtraControls;
  
   
  const CounterPanel({
    super.key,
    required this.currentCount,
    required this.showExtraControls,
    this.totalCount,
    this.onIncrement,
    this.onDecrement,
    this.onReset,
    this.isMiniActive = false,
    this.onMiniCounterPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        
        //: Botón mini contador
        if(showExtraControls)
        Positioned(
          left: 10,
          child: _ButtonContainer(
            child: IconButton(
              onPressed: onMiniCounterPressed,
              icon: const Icon(Icons.photo_size_select_small_rounded),
              iconSize: AppIconSize.small,
              color: isMiniActive ? AppTheme.functionActiveColor : null,
            ),
          ),
        ),
        

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            //: Disminuir el contador
            _ButtonContainer(
              child: IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove),
                iconSize: AppIconSize.small,
              ),
            ),
        
            const SizedBox(width: 10.0),

            //: Mostrar el contador actual y el total (si se proporciona)
            Text(
              totalCount != null
                ? '$currentCount / $totalCount'
                : '$currentCount',
              style: const TextStyle(
                fontSize: AppTextSize.medium,
              ),
            ),
        
            const SizedBox(width: 10.0),

            //: Aumentar el contador
            _ButtonContainer(
              child: IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add),
                iconSize: AppIconSize.small,
              ),
            ),
          ],
        ),

        //: Botón de reinicio
        if(showExtraControls)
        Positioned(
          right: 10,
          child: _ButtonContainer(
            child: IconButton(
              onPressed: onReset,
              icon: const Icon(Icons.refresh),
              iconSize: AppIconSize.small,
            ),
          ),
        ),
        
      ],
    );
  }
}




class _ButtonContainer extends StatelessWidget {

  final Widget child;
   
  const _ButtonContainer({
    required this.child,
  });
  
  @override
  Widget build(BuildContext context) {

    const double buttonSize = 30.0;

    return Container(
      height: buttonSize,
      width: buttonSize,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    );
  }
}