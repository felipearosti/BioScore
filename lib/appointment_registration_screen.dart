import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bioscore_provider.dart';

class AppointmentRegistrationScreen extends StatefulWidget {
  const AppointmentRegistrationScreen({super.key});

  @override
  State<AppointmentRegistrationScreen> createState() => _AppointmentRegistrationScreenState();
}

class _AppointmentRegistrationScreenState extends State<AppointmentRegistrationScreen> {
  static const Color _backgroundColor = Color(0xFFF8F9FA);
  static const Color _primaryColor = Color(0xFF1A365D);
  static const Color _accentColor = Color(0xFF2A9D8F);
  static const Color _fieldBorderColor = Color(0xFFDCE3EA);

  final _formKey = GlobalKey<FormState>();

  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _notesController = TextEditingController();

  final List<String> _appointmentTypes = const [
    'Primeira Consulta',
    'Retorno',
    'Bioimpedancia',
    'Teleconsulta',
  ];

  String? _selectedPatient;
  String? _selectedAppointmentType;

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration({
    required String label,
    required IconData icon,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: _accentColor),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _fieldBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _fieldBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _accentColor, width: 1.5),
      ),
    );
  }

  String? _requiredTextValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Preencha este campo';
    }
    return null;
  }

  String? _requiredDropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Selecione uma opcao';
    }
    return null;
  }

  void _confirmAppointment() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newAppointment = Appointment(
      patientName: _selectedPatient!.trim(),
      date: _dateController.text.trim(),
      time: _timeController.text.trim(),
      type: _selectedAppointmentType!.trim(),
    );

    context.read<BioScoreProvider>().addAppointment(newAppointment);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Consulta agendada com sucesso!'),
        backgroundColor: _accentColor,
      ),
    );

    Future.delayed(const Duration(milliseconds: 350), () {
      if (!mounted) {
        return;
      }
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final patients = context.watch<BioScoreProvider>().patients;

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Agendar Consulta'),
        backgroundColor: _backgroundColor,
        foregroundColor: _primaryColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _selectedPatient,
                  validator: _requiredDropdownValidator,
                  decoration: _fieldDecoration(
                    label: 'Selecao de Paciente',
                    icon: Icons.person_outline,
                  ),
                  items: patients
                      .map(
                        (patient) => DropdownMenuItem<String>(
                          value: patient.name,
                          child: Text(patient.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPatient = value;
                    });
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _dateController,
                  validator: _requiredTextValidator,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  decoration: _fieldDecoration(
                    label: 'Data da Consulta',
                    icon: Icons.calendar_today_outlined,
                    hint: 'DD/MM/AAAA',
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _timeController,
                  validator: _requiredTextValidator,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  decoration: _fieldDecoration(
                    label: 'Horario',
                    icon: Icons.access_time_outlined,
                    hint: 'HH:MM',
                  ),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: _selectedAppointmentType,
                  validator: _requiredDropdownValidator,
                  decoration: _fieldDecoration(
                    label: 'Tipo de Atendimento',
                    icon: Icons.medical_services_outlined,
                  ),
                  items: _appointmentTypes
                      .map(
                        (type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAppointmentType = value;
                    });
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  decoration: _fieldDecoration(
                    label: 'Observacoes',
                    icon: Icons.sticky_note_2_outlined,
                    hint: 'Anotacoes extras da consulta',
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _confirmAppointment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Confirmar Agendamento',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
