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
      final concentration = double.tryParse(_concentrationController.text) ?? 0;
      final dose = double.tryParse(_doseController.text) ?? 0;
      final weight = double.tryParse(_weightController.text) ?? 0;
      final dilution = double.tryParse(_dilutionController.text) ?? 0;

      if (concentration > 0 && dose > 0 && weight > 0 && dilution > 0) {
        final calculatedDose = _calculateDose(dose, weight, concentration);
        final rateFix = dilution == 12 ? '0.5' : '1.0';
        _result = '$_selectedDrug: расчетная доза ${calculatedDose.toStringAsFixed(2)} мл развести до $dilution мл. '
                  'При скорости $rateFix мл/час доза составит ${dose.toStringAsFixed(2)} мкг/кг/мин.\n';
        _result += _generateDoseTable(dose);
      } else {
        _result = 'Заполните все поля!';
      }
    });
  }

  double _calculateDose(double dose, double weight, double concentration) {
    final multiplier = _selectedDrug == 'Адреналин' || _selectedDrug == 'Норадреналин'
        ? 1.44 : 1.44;
    return (dose * weight * multiplier) / (concentration * 1000);
  }

 String _generateDoseTable(double dose) {
  final buffer = StringBuffer('Скорость (мл/ч) - Доза (мкг/кг/мин):\n');
  final multiplier = dose > 0.9 ? 1 : 10;
  for (double rate = 0.1; rate <= 1.0; rate += 0.1) {
  final doseAtRate = (dose * rate) / 1.0 * multiplier; 

    // Условие для вывода с разной точностью
    final doseFormatted = dose > 0.9
        ? doseAtRate.toStringAsFixed(1)
        : doseAtRate.toStringAsFixed(3);

    buffer.writeln('${rate.toStringAsFixed(1)} мл/ч - $doseFormatted мкг/кг/мин');
  }
  return buffer.toString();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькулятор дозировки')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDrugSelectionRow(),
            const SizedBox(height: 16.0),
            _buildInputFieldsRow(),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: _calculateSolution,
                child: const Text('Рассчитать'),
              ),
            ),
            const SizedBox(height: 24.0),
            Text(_result, style: const TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }

  Row _buildDrugSelectionRow() {
    return Row(
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
    );
  }

  Row _buildInputFieldsRow() {
    return Row(
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
    );
  }
}
