import 'package:flutter/material.dart';
import 'package:nicu_help/model/patient_profile.dart';
import 'package:nicu_help/features/edit_patient_screen/view/view.dart';

class NicuHelpMainScreenNew extends StatefulWidget {
  const NicuHelpMainScreenNew({super.key});

  @override
  State<NicuHelpMainScreenNew> createState() => _NicuHelpMainScreenNewState();
}

class _NicuHelpMainScreenNewState extends State<NicuHelpMainScreenNew> {
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
              leading: Icon(Icons.history),
              title: const Text('История пациентов'),
              onTap: () {
                // Логика перехода к истории пациентов
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: const Text('Протоколы интенсивной терапии'),
              onTap: () {
                // Логика перехода к протоколам
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Информация о пациенте
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Пациент: ${patient.name}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Кнопки с быстрым доступом к функциям
            Text(
              'Быстрый доступ:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            GridView.count(
              crossAxisCount: 3, // Уменьшили количество колонок до 3 для компактности
              crossAxisSpacing: 6.0,
              mainAxisSpacing: 6.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildFeatureButton(
                  context,
                  icon: Icons.calculate,
                  label: 'Дозировки',
                  route: '/drug_doses',
                ),
                _buildFeatureButton(
                  context,
                  icon: Icons.opacity,
                  label: 'Жидкость',
                  route: '/fluid_calculator',
                ),
                _buildFeatureButton(
                  context,
                  icon: Icons.air,
                  label: 'Вентиляция',
                  route: '/ventilation_screen',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton(BuildContext context,
      {required IconData icon, required String label, required String route}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      ),
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28), // Уменьшил размер иконок
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14), // Уменьшил размер текста
          ),
        ],
      ),
    );
  }
}
