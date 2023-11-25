import 'package:flutter/material.dart';
import 'package:flutter_application/services/cart/filter_service.dart';
import 'package:provider/provider.dart';
import 'checkbox.dart';

class ClothingOptionsPanel extends StatefulWidget {
  const ClothingOptionsPanel({super.key});

  @override
  State<ClothingOptionsPanel> createState() => _ClothingOptionsPanelState();
}

class _ClothingOptionsPanelState extends State<ClothingOptionsPanel> {
  @override
  Widget build(BuildContext context) {
    //List<String> selectedOptions = context.watch<FilterService>().items;

    void updateSelectedOptions(String option, bool selected) {
      setState(() {
        if (selected) {
          context.read<FilterService>().addFilter(option);
        } else {
          context.read<FilterService>().removeFilter(option);
        }
        selected = !selected;
      });
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          CheckboxExample(
            nomeTipo: 'Infantil',
            onCheckboxChanged: (bool isChecked) {
              updateSelectedOptions('Infantil', isChecked);
            },
          ),
          CheckboxExample(
            nomeTipo: 'Suéter',
            onCheckboxChanged: (bool isChecked) {
              updateSelectedOptions('Suéter', isChecked);
            },
          ),
          CheckboxExample(
            nomeTipo: 'Casaco',
            onCheckboxChanged: (bool isChecked) {
              updateSelectedOptions('Casaco', isChecked);
            },
          ),
          CheckboxExample(
            nomeTipo: 'Camiseta',
            onCheckboxChanged: (bool isChecked) {
              updateSelectedOptions('Camiseta', isChecked);
            },
          ),
          CheckboxExample(
            nomeTipo: 'Meia',
            onCheckboxChanged: (bool isChecked) {
              updateSelectedOptions('Meia', isChecked);
            },
          ),
          CheckboxExample(
            nomeTipo: 'Sapato',
            onCheckboxChanged: (bool isChecked) {
              updateSelectedOptions('Sapato', isChecked);
            },
          ),
          CheckboxExample(
            nomeTipo: 'Calça',
            onCheckboxChanged: (bool isChecked) {
              updateSelectedOptions('Calça', isChecked);
            },
          ),
          CheckboxExample(
            nomeTipo: 'Bermuda',
            onCheckboxChanged: (bool isChecked) {
              updateSelectedOptions('Bermuda', isChecked);
            },
          ),
          CheckboxExample(
            nomeTipo: 'Saia',
            onCheckboxChanged: (bool isChecked) {
              updateSelectedOptions('Saia', isChecked);
            },
          ),
          //SizedBox(height: 16),
          //Text('Opções selecionadas: ${selectedOptions.join(', ')}'),
        ],
      ),
    );
  }
}
/*
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
}*/