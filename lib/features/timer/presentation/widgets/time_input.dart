import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeInput extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const TimeInput({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.value.toString();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Content(onChanged: widget.onChanged, value: widget.value, controller: controller);
  }
}



class _Content extends StatelessWidget {
  const _Content({
    required this.onChanged,
    required this.value,
    required this.controller,
  });

  final TextEditingController controller;
  final ValueChanged<int> onChanged;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          //: Texto que muestra el valor actual del input
          Expanded(
            child: _TextField(
              onChanged: (text) {
                final intValue = int.tryParse(text) ?? 0;
                onChanged(intValue);
              },
              value: value,
              controller: controller,
            ),
          ),
          
          //: Botones para incrementar o decrementar el valor
          Column(
            children: [
              InkWell(
                onTap: () {
                  int newValue = value + 1;
                  controller.text = newValue.toString();
                  onChanged(newValue);
                },
                child: const Icon(Icons.keyboard_arrow_up, size: 14, color: Colors.white60),
              ),
              InkWell(
                onTap: () {
                  int newValue = value > 0 ? value - 1 : 0;
                  controller.text = newValue.toString();
                  onChanged(newValue);
                },
                child: const Icon(Icons.keyboard_arrow_down, size: 14, color: Colors.white60),
              ),
            ],
          )
        ],
      ),
    );
  }
}



class _TextField extends StatelessWidget {

  final Function(String) onChanged;
  final int value;
  final TextEditingController controller;
   
  const _TextField({
    required this.onChanged,
    required this.value,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: TextField(
        expands: true,
        maxLines: null,
        minLines: null,
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          // Limita la entrada a solo dígitos
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: onChanged,
      ),
    );
  }
}