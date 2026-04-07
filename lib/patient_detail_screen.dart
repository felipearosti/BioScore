import 'package:flutter/material.dart';

import 'bioscore_provider.dart';

class PatientDetailScreen extends StatelessWidget {
  const PatientDetailScreen({super.key, required this.patient});

  final Patient patient;

  static const Color _backgroundColor = Color(0xFFF8F9FA);
  static const Color _primaryColor = Color(0xFF1A365D);
  static const Color _accentColor = Color(0xFF2A9D8F);
  static const Color _cardBorderColor = Color(0xFFDCE3EA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Detalhes do Paciente'),
        backgroundColor: _backgroundColor,
        foregroundColor: _primaryColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HeaderCard(patient: patient),
            const SizedBox(height: 16),
            _InfoCard(
              title: 'Dados cadastrais',
              children: [
                _InfoRow(label: 'Nome completo', value: patient.name),
                _InfoRow(label: 'CPF', value: patient.cpf),
                _InfoRow(label: 'Data de nascimento', value: patient.birthDate),
              ],
            ),
            const SizedBox(height: 16),
            _InfoCard(
              title: 'Dados de composição',
              children: [
                _InfoRow(label: 'Peso inicial', value: '${patient.weight} kg'),
                _InfoRow(label: 'Altura', value: '${patient.height} m'),
                _InfoRow(label: 'Objetivo principal', value: patient.goal),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PatientDetailScreen._cardBorderColor),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFFE5F4F2),
            child: Text(
              patient.name.isEmpty ? '-' : patient.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                color: PatientDetailScreen._primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.name,
                  style: const TextStyle(
                    color: PatientDetailScreen._primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  patient.goal,
                  style: const TextStyle(
                    color: PatientDetailScreen._accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PatientDetailScreen._cardBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: PatientDetailScreen._accentColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: PatientDetailScreen._primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 8, color: PatientDetailScreen._accentColor),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: PatientDetailScreen._primaryColor,
                  fontSize: 15,
                  height: 1.4,
                ),
                children: [
                  TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}