import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class CustomAppBar extends StatelessWidget {
   
  const CustomAppBar({super.key});
  
  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
                      
            const Spacer(), // Empuja los botones de control a la derecha
            
            // Botón Minimizar
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.white, size: 18),
              onPressed: () async {
                await windowManager.minimize();
              },
            ),
            // Botón Cerrar
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 18),
              onPressed: () async {
                await windowManager.close();
              },
            ),
          ],
        ),
      ),
    );
  }
}
