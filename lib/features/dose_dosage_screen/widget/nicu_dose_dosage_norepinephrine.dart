import 'package:flutter/material.dart';

class NoradrenalinForm extends StatefulWidget {
  const NoradrenalinForm({super.key});

  @override
  _NoradrenalinFormState createState() => _NoradrenalinFormState();
}

class _NoradrenalinFormState extends State<NoradrenalinForm> {
  final TextEditingController _concentrationController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _dilutionController = TextEditingController();
  String _result = '';

  void _calculateDose() {
    setState(() {
      final concentration = double.tryParse(_concentrationController.text) ?? 0;
      final dose = double.tryParse(_doseController.text) ?? 0;
      final weight = double.tryParse(_weightController.text) ?? 0;
      final dilution = double.tryParse(_dilutionController.text) ?? 0;

      if (concentration > 0 && dose > 0 && weight > 0 && dilution > 0) {
        final calculatedDose = (dose * weight * 1.44) / (concentration * 1000);
        final rateFix = dilution == 12 ? '0.5' : '1.0';
        _result = 'Норадреналин: расчетная доза ${calculatedDose.toStringAsFixed(2)} мл развести до $dilution мл. '
                  'При скорости $rateFix мл/час доза составит ${dose.toStringAsFixed(2)} мкг/кг/мин.\n';
        _result += _generateDoseTable(dose);
      } else {
        _result = 'Заполните все поля!';
      }
    });
  }

  String _generateDoseTable(double dose) {
    final buffer = StringBuffer('Скорость (мл/ч) - Доза (мкг/кг/мин):\n');
    final multiplier = dose > 0.9 ? 1 : 10;
    for (double rate = 0.1; rate <= 1.0; rate += 0.1) {
      final doseAtRate = (dose * rate) / 1.0 * multiplier;
      final doseFormatted = dose > 0.9
          ? doseAtRate.toStringAsFixed(1)
          : doseAtRate.toStringAsFixed(3);
      buffer.writeln('${rate.toStringAsFixed(1)} мл/ч - $doseFormatted мкг/кг/мин');
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _concentrationController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Концентрация Норадреналина (%)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _doseController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Доза (мкг/кг/мин)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _weightController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Вес ребёнка (в граммах)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _dilutionController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Развести до (мл)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _calculateDose,
          child: const Text('Рассчитать'),
        ),
        const SizedBox(height: 16.0),
        Text(_result, style: const TextStyle(fontSize: 16.0)),
      ],
    );
  }
}
