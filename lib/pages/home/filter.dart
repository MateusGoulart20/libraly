import 'package:flutter/material.dart';
import 'Checkbox.dart';

class ClothingOptionsPanel extends StatefulWidget {
  @override
  _ClothingOptionsPanelState createState() => _ClothingOptionsPanelState();
}

class _ClothingOptionsPanelState extends State<ClothingOptionsPanel> {
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione as opções de roupas:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CheckboxExample(
            nomeTipo: 'Feminino',
            onCheckboxChanged: (bool isChecked){
              updateSelectedOptions('Feminino', isChecked);
            },
          ),
          CheckboxExample(
            nomeTipo: 'Camiseta',
            onCheckboxChanged: (bool isChecked){
              updateSelectedOptions('Camiseta', isChecked);
            },
          ),
          CheckboxExample(
            nomeTipo: 'Meia',
            onCheckboxChanged: (bool isChecked){
              updateSelectedOptions('Meia', isChecked);
            },
          ),
          CheckboxExample(
            nomeTipo: 'Sapato',
            onCheckboxChanged: (bool isChecked){
              updateSelectedOptions('Sapato', isChecked);
            },
          ),
          CheckboxExample(
            nomeTipo: 'Calça',
            onCheckboxChanged: (bool isChecked){
              updateSelectedOptions('Calça', isChecked);
            },
          ),
          SizedBox(height: 16),
          Text('Opções selecionadas: ${selectedOptions.join(', ')}'),
        ],
      ),
    );
  }

  void updateSelectedOptions(String option, bool selected) {
    setState(() {
      if (selected) {
        selectedOptions.add(option);
      } else {
        selectedOptions.remove(option);
      }
      selected = !selected;
    });
  }
}

class CheckboxOption extends StatelessWidget {
  final String label;
  final ValueChanged<bool?>? onChanged;

  const CheckboxOption({
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: onChanged,
        ),
        Text(label),
      ],
    );
  }
}