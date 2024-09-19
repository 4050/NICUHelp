import 'package:flutter/material.dart';
import 'package:nicu_help/model/patient_profile.dart';
import 'package:nicu_help/features/edit_patient_screen/view/view.dart';

class NicuHelpMainScreenNew extends StatefulWidget {
  const NicuHelpMainScreenNew({super.key});

  @override
  State<NicuHelpMainScreenNew> createState() => _NicuHelpMainScreenNewState();
}

class _NicuHelpMainScreenNewState extends State<NicuHelpMainScreenNew> {
  // Пример профиля пациента
  PatientProfile patient = PatientProfile(
    name: "Иван Иванов",
    dateOfBirth: DateTime(2024, 1, 15),
    weight: 3.2,
    height: 50.0,
  );

  void _editPatient(PatientProfile updatedPatient) {
    setState(() {
      patient = updatedPatient;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NICU Help'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPatientScreen(
                    patient: patient,
                    onSave: _editPatient,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'NICU Help Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('История пациентов'),
              onTap: () {
                // Логика перехода к истории пациентов
              },
            ),
            ListTile(
              title: const Text('Протоколы интенсивной терапии'),
              onTap: () {
                // Логика перехода к протоколам
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Информация о пациенте
            Text(
              'Пациент: ${patient.name}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Дата рождения: ${patient.dateOfBirth.toLocal()}'.split(' ')[0],
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Вес: ${patient.weight} кг',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Рост: ${patient.height} см',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),

            // Кнопки с быстрым доступом к функциям
            Expanded(
              child: ListView(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/drug_doses');
                    },
                    child: const Text('Калькулятор дозировок препаратов'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/fluid_calculator');
                    },
                    child: const Text('Калькулятор жидкости'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/ventilation_parameters');
                    },
                    child: const Text('Вентиляционные параметры'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
