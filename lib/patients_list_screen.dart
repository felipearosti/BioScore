import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bioscore_provider.dart';
import 'patient_registration_screen.dart';

class PatientsListScreen extends StatelessWidget {
  const PatientsListScreen({super.key});

  static const Color _backgroundColor = Color(0xFFF8F9FA);
  static const Color _primaryColor = Color(0xFF1A365D);
  static const Color _accentColor = Color(0xFF2A9D8F);

  Future<void> _confirmDeletePatient(BuildContext context, Patient patient) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Excluir Paciente?'),
          content: Text(
            'Tem certeza que deseja excluir ${patient.name}? Isso tambem removera todas as consultas agendadas para ele.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true || !context.mounted) {
      return;
    }

    context.read<BioScoreProvider>().deletePatient(patient);

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        const SnackBar(
          content: Text('Paciente e agendas removidos com sucesso'),
          backgroundColor: _accentColor,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final patients = context.watch<BioScoreProvider>().patients;

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Pacientes'),
        backgroundColor: _backgroundColor,
        foregroundColor: _primaryColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: patients.isEmpty
          ? const Center(
              child: Text(
                'Nenhum paciente cadastrado.',
                style: TextStyle(color: _primaryColor, fontWeight: FontWeight.w600),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 84),
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFE5F4F2),
                      child: Text(
                        patient.name.isEmpty ? '-' : patient.name.substring(0, 1).toUpperCase(),
                        style: const TextStyle(color: _primaryColor, fontWeight: FontWeight.w700),
                      ),
                    ),
                    title: Text(
                      patient.name,
                      style: const TextStyle(color: _primaryColor, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text('CPF: ${patient.cpf}\nObjetivo: ${patient.goal}'),
                    isThreeLine: true,
                    trailing: IconButton(
                      tooltip: 'Excluir paciente',
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _confirmDeletePatient(context, patient),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _accentColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PatientRegistrationScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
