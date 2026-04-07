import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bioscore_provider.dart';

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key});

  @override
  State<PatientRegistrationScreen> createState() => _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  static const Color _backgroundColor = Color(0xFFF8F9FA);
  static const Color _primaryColor = Color(0xFF1A365D);
  static const Color _accentColor = Color(0xFF2A9D8F);
  static const Color _fieldBorderColor = Color(0xFFDCE3EA);

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _goalController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    _birthDateController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _goalController.dispose();
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

  void _savePatient() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newPatient = Patient(
      name: _nameController.text.trim(),
      cpf: _cpfController.text.trim(),
      goal: _goalController.text.trim(),
    );

    context.read<BioScoreProvider>().addPatient(newPatient);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Paciente cadastrado com sucesso!'),
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

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Preencha este campo';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Cadastrar Novo Paciente'),
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
                TextFormField(
                  controller: _nameController,
                  validator: _requiredValidator,
                  textInputAction: TextInputAction.next,
                  decoration: _fieldDecoration(
                    label: 'Nome Completo',
                    icon: Icons.person_outline,
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _cpfController,
                  validator: _requiredValidator,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: _fieldDecoration(
                    label: 'CPF',
                    icon: Icons.badge_outlined,
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _birthDateController,
                  validator: _requiredValidator,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.datetime,
                  decoration: _fieldDecoration(
                    label: 'Data de Nascimento',
                    icon: Icons.calendar_today_outlined,
                    hint: 'DD/MM/AAAA',
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _weightController,
                        validator: _requiredValidator,
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: _fieldDecoration(
                          label: 'Peso Inicial (kg)',
                          icon: Icons.monitor_weight_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _heightController,
                        validator: _requiredValidator,
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: _fieldDecoration(
                          label: 'Altura (m)',
                          icon: Icons.height,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _goalController,
                  validator: _requiredValidator,
                  maxLines: 2,
                  textInputAction: TextInputAction.done,
                  decoration: _fieldDecoration(
                    label: 'Objetivo Principal',
                    icon: Icons.gps_fixed,
                    hint: 'Ex: Emagrecimento, Hipertrofia',
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _savePatient,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accentColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Salvar Cadastro',
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
