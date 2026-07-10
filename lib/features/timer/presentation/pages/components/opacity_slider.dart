import 'package:flutter/material.dart';

class OpacitySlider extends StatelessWidget {

  final double backgroundOpacity;
  final ValueChanged<double> onChanged;
   
  const OpacitySlider({
    super.key,
    required this.backgroundOpacity,
    required this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Opacidad: ${(backgroundOpacity * 100).toInt()}%',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        SizedBox(height: 5.0),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 1,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 10),
            inactiveTrackColor: Colors.grey,
          ),
          child: Slider(
            value: backgroundOpacity, 
            min: 0.1, max: 1, divisions: 19,
            onChanged: onChanged,
          ),
        ),
        SizedBox(height: 15.0),
      ],
    );
  }
}