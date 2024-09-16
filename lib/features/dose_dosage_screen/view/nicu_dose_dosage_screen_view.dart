import 'package:flutter/material.dart';


class DrugDosageScreen extends StatefulWidget {
  const DrugDosageScreen({super.key});
  
  @override
  State<DrugDosageScreen> createState() => _DrugDosageScreenState();
}

class _DrugDosageScreenState extends State<DrugDosageScreen> {
  String _selectedDrug = 'Адреналин';
  final List<String> _drugs = ['Адреналин', 'Норадреналин', 'Добутамин'];
  final TextEditingController _concentrationController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _dilutionController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  String _result = '';

  void _calculateSolution() {
    setState(() {
      String drug = _selectedDrug;
      String concentration = _concentrationController.text;
      String dose = _doseController.text;
      String dilution = _dilutionController.text;
      String weight = _weightController.text;

      if (concentration.isNotEmpty && dose.isNotEmpty && dilution.isNotEmpty) {
        _result =
            'Препарат: $drug, растворить в $dilution мл. Концентрация: $concentration%, доза: $dose мкг/кг/мин.';
      } else {
        _result = 'Заполните все поля!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор дозировки'),
      ),
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
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _concentrationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Концентрация (%)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _doseController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Доза (мкг/кг/мин)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                 Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Вес ребенка (в граммах)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _dilutionController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Развести до (мл)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: _calculateSolution,
                child: const Text('Рассчитать'),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              _result,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
