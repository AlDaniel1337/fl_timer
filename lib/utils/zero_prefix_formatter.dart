import 'package:flutter/services.dart';

class ZeroPrefixFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text;

    // Si está vacío, lo dejamos vacío para que puedan borrar todo
    if (text.isEmpty) return newValue;
    
    // Si el usuario escribe algo que no sea un número, lo rechazamos
    if (!RegExp(r'^\d+$').hasMatch(text)) return oldValue;
    
    // Convertimos a entero para limpiar ceros a la izquierda innecesarios (ej: "015" -> 15)
    int? number = int.tryParse(text);
    
    if (number == null) return oldValue;

    String newString;
    if (number < 10) {
      // Si es menor a 10 (un solo dígito, ej: 7), le clavamos el 0 adelante -> "07"
      // Si el usuario intentó poner "00", el número es 0, y se formateará como "00" temporalmente, 
      // pero con la regla de abajo manejamos que si el texto original era "0" y escribe otro "0", se quede en "0".
      if (text == '00') {
        newString = '0';
      } else {
        newString = '0$number';
      }
    } else {
      // Si es 10 o mayor (ej: 15), se muestra tal cual -> "15"
      newString = number.toString();
    }

    // Retornamos el nuevo valor manteniendo el cursor al final del texto
    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}