import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
   
  const CounterButton({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
       width: double.infinity,
       height: 50,
       color: Colors.red
    );
  }
}