import 'package:flutter/material.dart';
import 'package:nicu_help/model/patient_profile.dart';

class EditPatientScreen extends StatefulWidget {
  final PatientProfile patient;
  final Function(PatientProfile) onSave;

  const EditPatientScreen({
    super.key,
    required this.patient,
    required this.onSave,
  });

  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  late TextEditingController _nameController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.patient.name);
    _weightController = TextEditingController(text: widget.patient.weight.toString());
    _heightController = TextEditingController(text: widget.patient.height.toString());
    _selectedDate = widget.patient.dateOfBirth;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _savePatient() {
    final updatedPatient = PatientProfile(
      name: _nameController.text,
      dateOfBirth: _selectedDate ?? widget.patient.dateOfBirth,
      weight: double.tryParse(_weightController.text) ?? widget.patient.weight,
      height: double.tryParse(_heightController.text) ?? widget.patient.height,
    );
    widget.onSave(updatedPatient);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать пациента'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePatient,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Имя'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Вес (кг)'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Рост (см)'),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Text(
                  'Дата рождения: ${_selectedDate?.toLocal()}'.split(' ')[0],
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Выбрать дату'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
