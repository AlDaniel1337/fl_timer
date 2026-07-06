import 'package:flutter/material.dart';
import 'package:timer/constants/app_sizes.dart';

class CounterPanel extends StatelessWidget {

  final int currentCount;
  final int? totalCount;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onReset;
  
   
  const CounterPanel({
    super.key,
    required this.currentCount,
    this.totalCount,
    this.onIncrement,
    this.onDecrement,
    this.onReset,
  });
  
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
            _ButtonContainer(
              child: IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove),
                iconSize: AppIconSize.small,
              ),
            ),
        
            const SizedBox(width: 10.0),
        
            Text(
              totalCount != null
                ? '$currentCount / $totalCount'
                : '$currentCount',
              style: const TextStyle(
                fontSize: AppTextSize.medium,
              ),
            ),
        
            const SizedBox(width: 10.0),
        
            _ButtonContainer(
              child: IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add),
                iconSize: AppIconSize.small,
              ),
            ),
          ],
        ),

        if(onReset != null) ...[
          Positioned(
            right: 20,
            child: _ButtonContainer(
              child: IconButton(
                onPressed: onReset,
                icon: const Icon(Icons.refresh),
                iconSize: AppIconSize.small,
              ),
            ),
          ),
        ]
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