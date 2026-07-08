import 'package:flutter/material.dart';
import 'package:timer/constants/app_sizes.dart';
import 'package:timer/core/theme/app_theme.dart';
import 'package:timer/features/timer/domain/models/panel_icon_button.dart';

class ControlPanel extends StatelessWidget {

  final List<PanelIconButton> panelButtons;
  final bool isMini;
   
  const ControlPanel({
    super.key, 
    this.panelButtons = const [],
    this.isMini = false
  });
  
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: panelButtons.map((button) => IconButton(
        onPressed: button.onPressed,
        icon: Icon(button.icon),
        color: AppTheme.textLight,
        iconSize: isMini 
          ? AppIconSize.small + button.extraSize 
          : AppIconSize.medium + button.extraSize
      )).toList()
    );
  }
}