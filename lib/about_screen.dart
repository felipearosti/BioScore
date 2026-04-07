import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const Color _backgroundColor = Color(0xFFF8F9FA);
  static const Color _primaryTextColor = Color(0xFF1A365D);
  static const Color _accentColor = Color(0xFF2A9D8F);
  static const Color _cardBorderColor = Color(0xFFDCE3EA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Sobre o Projeto'),
        backgroundColor: _backgroundColor,
        foregroundColor: _primaryTextColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 16),
            _buildSectionCard(
              title: 'Objetivo do Aplicativo',
              icon: Icons.track_changes_outlined,
              child: const Text(
                'Desenvolver uma aplicação Web/Mobile para otimizar o fluxo de atendimento e a tomada de decisão clínica. '
                'O sistema substitui controles manuais por um dashboard inteligente que processa os dados de bioimpedância '
                'e histórico do paciente, oferecendo uma visão clara da evolução em tratamentos de metabologia.',
                style: TextStyle(height: 1.45, color: _primaryTextColor, fontSize: 15),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              title: 'Equipe de Desenvolvimento (OmniDart Solutions)',
              icon: Icons.groups_outlined,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• Felipe Arosti Felisbino (RA: 839913)',
                    style: TextStyle(color: _primaryTextColor, fontSize: 15, height: 1.4),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '• Leone Carpine da Silva (RA: 840588)',
                    style: TextStyle(color: _primaryTextColor, fontSize: 15, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              title: 'Informações Acadêmicas',
              icon: Icons.school_outlined,
              child: const Column(
                children: [
                  _InfoTile(
                    label: 'Instituição',
                    value: 'UNAERP - Universidade de Ribeirão Preto (Engenharia de Software)',
                  ),
                  SizedBox(height: 10),
                  _InfoTile(label: 'Disciplina', value: 'Mobile II'),
                  SizedBox(height: 10),
                  _InfoTile(label: 'Professor', value: 'Samuel Zanferdini Oliva'),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _cardBorderColor),
        boxShadow: const [
          BoxShadow(color: Color(0x10000000), blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_rounded, color: _accentColor),
              SizedBox(width: 8),
              Text(
                'BioScore Web',
                style: TextStyle(
                  color: _primaryTextColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Versão 1.0.0',
            style: TextStyle(
              color: _accentColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _cardBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _accentColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.circle, size: 8, color: AboutScreen._accentColor),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: AboutScreen._primaryTextColor, fontSize: 15, height: 1.4),
              children: [
                TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
