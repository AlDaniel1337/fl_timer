import 'package:flutter/material.dart';

class PanelIconButton {
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final IconData icon;
  final IconData? secondaryIcon;
  final double extraSize;

  const PanelIconButton({
    required this.onPressed,
    this.onLongPress,
    required this.icon,
    this.secondaryIcon,
    this.extraSize = 0.0
  });
}
