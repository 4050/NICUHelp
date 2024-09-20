import 'package:flutter/material.dart';
//import 'adrenalin_form.dart';
import 'package:nicu_help/features/dose_dosage_screen/widget/widget.dart';
//import 'dobutamin_form.dart';

class DrugDosageScreen extends StatefulWidget {
  const DrugDosageScreen({super.key});

  @override
  State<DrugDosageScreen> createState() => _DrugDosageScreenState();
}

class _DrugDosageScreenState extends State<DrugDosageScreen> {
  String _selectedDrug = 'Адреналин';
  final List<String> _drugs = ['Адреналин', 'Норадреналин', 'Добутамин'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькулятор дозировки')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DropdownButton<String>(
                  value: _selectedDrug,
                  items: _drugs.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedDrug = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _buildDrugSpecificForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrugSpecificForm() {
    switch (_selectedDrug) {
      case 'Адреналин':
        return AdrenalinForm();
      case 'Норадреналин':
        return NoradrenalinForm();
      case 'Добутамин':
        return DobutaminForm();
      default:
        return const Text('Выберите препарат');
    }
  }
}
