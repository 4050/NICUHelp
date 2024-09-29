import 'package:flutter/material.dart';

class VentilationScreen extends StatefulWidget {
  const VentilationScreen({super.key});
  @override
  _VentilationScreenState createState() => _VentilationScreenState();
}

class _VentilationScreenState extends State<VentilationScreen> {
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();

  String _ageUnit = 'Месяцы'; // Выбранная единица измерения возраста

  double tidalVolume = 0;
  double respiratoryRate = 0;
  double peep = 0;
  double fio2 = 0;

  // Функция для расчета параметров ИВЛ
  void calculateVentilationParameters() {
    final age = int.tryParse(_ageController.text);
    final weight = double.tryParse(_weightController.text);

    if (age != null && weight != null) {
      setState(() {
        tidalVolume = weight * 6; // 6 мл/кг - обычный объем для ИВЛ

        // Рассчет частоты дыхания в зависимости от возраста и единиц измерения
        if (_ageUnit == 'Дни') {
          respiratoryRate = age < 30 ? 60 : 50; // Пример для младенцев до месяца
        } else {
          respiratoryRate = age < 1 ? 40 : (age <= 5 ? 30 : 20); // Пример для возраста в месяцах
        }

        peep = 5; // Начальное значение PEEP
        fio2 = 0.21; // Начальное значение FiO2
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Параметры ИВЛ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Поле для ввода веса
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: 'Вес (кг)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // Поле для ввода возраста
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Возраст ($_ageUnit)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

            // Переключатель между днями и месяцами
            DropdownButton<String>(
              value: _ageUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _ageUnit = newValue!;
                });
              },
              items: <String>['Дни', 'Месяцы']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // Кнопка расчета параметров ИВЛ
            ElevatedButton(
              onPressed: calculateVentilationParameters,
              child: Text('Рассчитать параметры ИВЛ'),
            ),
            SizedBox(height: 16),

            // Отображение рассчитанных параметров
            Text('Объем вдоха (мл): $tidalVolume'),
            Text('Частота дыхания (в минуту): $respiratoryRate'),
            Text('PEEP: $peep'),
            Text('FiO2: $fio2'),
          ],
        ),
      ),
    );
  }
}
