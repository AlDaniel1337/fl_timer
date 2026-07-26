import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController? maxCountController;
  final ValueChanged<String>? onMaxCountChanged;
  
   
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
    this.maxCountController,
    this.onMaxCountChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        
        //: Botón: activar el modo [mini contador]
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
            
            //: Botón: disminuir el contador
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
              (totalCount != null && !showExtraControls)
                ? '$currentCount / $totalCount'
                : '$currentCount',
              style: const TextStyle(
                fontSize: AppTextSize.medium,
              ),
            ),
        
            //: Espacio ingresar el maximo de vueltas, solo visible si se muestran los controles extra
            if(showExtraControls) ...[
              const SizedBox(width: 5.0),
              Text( '/', style: const TextStyle( fontSize: AppTextSize.medium ) ),
              SizedBox(
                width: 40,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Max',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  ),
                  controller: maxCountController,
                  onTapOutside: (_) {
                    if (onMaxCountChanged != null) {
                      onMaxCountChanged!(maxCountController?.text ?? '0');
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onTap: () {
                    // Selecciona todo el texto al hacer clic en el campo de texto
                    maxCountController?.selection = TextSelection(
                      baseOffset: 0, 
                      extentOffset: maxCountController?.text.length ?? 0
                    );
                  },
                ),
              ),
            ],

            SizedBox(width: showExtraControls ? 3 : 10),

            //: Botón: aumentar el contador
            _ButtonContainer(
              child: IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add),
                iconSize: AppIconSize.small,
              ),
            ),

          ],
        ),


        //: Botón: reiniciar el contador
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




/// Contenedor para los botones del panel de control del contador, con un estilo consistente
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