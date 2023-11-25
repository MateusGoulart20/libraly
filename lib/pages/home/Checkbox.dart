import 'package:flutter/material.dart';

/// Flutter code sample for [Checkbox].

void main() => runApp(const CheckboxExampleApp());

class CheckboxExampleApp extends StatelessWidget {
  const CheckboxExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Checkbox Sample')),
        body: Center(
          child: CheckboxExample(
            nomeTipo: 'flor',
            onCheckboxChanged: (bool isChecked){
              print("Checkbox marcada: $isChecked");
            }, 
          ),
        ),
      ),
    );
  }
}

class CheckboxExample extends StatefulWidget {
  final String nomeTipo;
  // Callback para notificar mudança
  final Function(bool) onCheckboxChanged; 

  const CheckboxExample({super.key, required this.nomeTipo, required this.onCheckboxChanged});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.orange.shade400;
      }
      if (isChecked) {
        return Colors.purpleAccent.shade700;
      }
      return Colors.pink.shade50;
    }

    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
              // Chama o callback notificando a mudança
              widget.onCheckboxChanged(isChecked);
            });
          },
        ),
        Text(widget.nomeTipo),
      ],
    );
  }
}
