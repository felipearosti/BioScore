import 'package:flutter/material.dart';

class WeekDayOption {
  const WeekDayOption({required this.label, required this.day});

  final String label;
  final String day;
}

class PatientAppointment {
  const PatientAppointment({
    required this.name,
    required this.time,
    required this.goal,
  });

  final String name;
  final String time;
  final String goal;
}

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  static const Color _primaryColor = Color(0xFF2C3E50);
  static const Color _accentColor = Color(0xFF4DB6AC);
  static const Color _backgroundColor = Color(0xFFF0F4F8);
  static const Color _textColor = Color(0xFF2C3E50);
  static const Color _panelColor = Color(0xFFD1D9E6);

  final List<WeekDayOption> _weekDays = const [
    WeekDayOption(label: 'SEG', day: '06'),
    WeekDayOption(label: 'TER', day: '07'),
    WeekDayOption(label: 'QUA', day: '08'),
    WeekDayOption(label: 'QUI', day: '09'),
    WeekDayOption(label: 'SEX', day: '10'),
  ];

  final Map<String, List<PatientAppointment>> _appointmentsByDay = const {
    '06': [
      PatientAppointment(
        name: 'Carlos Mendonça',
        time: '08:00',
        goal: 'Análise de Bioimpedância',
      ),
      PatientAppointment(
        name: 'Marina Costa',
        time: '09:30',
        goal: 'Acompanhamento Nutricional',
      ),
      PatientAppointment(
        name: 'João Ferreira',
        time: '11:00',
        goal: 'Revisão de Metas Semanais',
      ),
    ],
    '07': [
      PatientAppointment(
        name: 'Ana Beatriz Lima',
        time: '08:15',
        goal: 'Avaliação Clínica Inicial',
      ),
      PatientAppointment(
        name: 'Ricardo Salles',
        time: '10:00',
        goal: 'Análise de Evolução Corporal',
      ),
    ],
    '08': [
      PatientAppointment(
        name: 'Fernanda Nogueira',
        time: '07:45',
        goal: 'Planejamento Alimentar',
      ),
      PatientAppointment(
        name: 'Paulo Henrique',
        time: '09:00',
        goal: 'Controle de Retenção Hídrica',
      ),
      PatientAppointment(
        name: 'Bruna Teixeira',
        time: '14:30',
        goal: 'Reavaliação Funcional',
      ),
    ],
    '09': [
      PatientAppointment(
        name: 'Eduardo Martins',
        time: '08:00',
        goal: 'Consulta de Ajuste Metabólico',
      ),
      PatientAppointment(
        name: 'Camila Rocha',
        time: '13:00',
        goal: 'Retorno Pós-Protocolo',
      ),
    ],
    '10': [
      PatientAppointment(
        name: 'Thiago Alves',
        time: '10:30',
        goal: 'Check-up de Composição Corporal',
      ),
      PatientAppointment(
        name: 'Larissa Gomes',
        time: '15:00',
        goal: 'Monitoramento de Adesão',
      ),
    ],
  };

  bool _isMenuExpanded = true;

  String get _todayDayNumber => DateTime.now().day.toString().padLeft(2, '0');

  Widget _menuItem({
    required IconData icon,
    required String label,
    bool selected = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFEAF2FB) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: _primaryColor),
        title: _isMenuExpanded
            ? Text(
                label,
                style: const TextStyle(
                  color: _textColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            : null,
        horizontalTitleGap: 8,
        minLeadingWidth: 24,
        onTap: () {},
      ),
    );
  }

  Widget _buildSideMenu() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: _isMenuExpanded ? 228 : 78,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Color(0xFFD3DCE5)),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 16, 14, 12),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: _accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.monitor_heart, color: _primaryColor, size: 20),
                ),
                if (_isMenuExpanded) ...[
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'BioScore',
                      style: TextStyle(
                        color: _primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFD3DCE5)),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                _menuItem(icon: Icons.calendar_today_rounded, label: 'Consultas', selected: true),
                _menuItem(icon: Icons.person_outline_rounded, label: 'Perfil'),
                _menuItem(icon: Icons.logout_rounded, label: 'Sair'),
              ],
            ),
          ),
          const Spacer(),
          const Divider(height: 1, color: Color(0xFFD3DCE5)),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
            child: Column(
              crossAxisAlignment: _isMenuExpanded
                  ? CrossAxisAlignment.stretch
                  : CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  tooltip: 'Configurações',
                  icon: const Icon(Icons.settings_outlined),
                  color: _primaryColor,
                ),
                if (_isMenuExpanded)
                  TextButton.icon(
                    onPressed: () => setState(() => _isMenuExpanded = false),
                    icon: const Icon(Icons.keyboard_double_arrow_left_rounded, size: 18),
                    label: const Text('Fechar menu'),
                  )
                else
                  IconButton(
                    onPressed: () => setState(() => _isMenuExpanded = true),
                    icon: const Icon(Icons.keyboard_double_arrow_right_rounded),
                    color: _primaryColor,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPatientDialog(PatientAppointment patient) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980, maxHeight: 680),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 12, 12),
                    child: Row(
                      children: [
                        const Text(
                          'Informações do Paciente',
                          style: TextStyle(
                            color: _primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close_rounded, color: Color(0xFF7B8798)),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFE3E8EF)),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle('Dados do Atendimento'),
                          const SizedBox(height: 12),
                          _infoGrid([
                            _fieldBox('Paciente', patient.name),
                            _fieldBox('Horário', patient.time),
                            _fieldBox('Objetivo', patient.goal),
                            _fieldBox('Status', 'Agendado'),
                            _fieldBox('Profissional', 'BioScore Health'),
                            _fieldBox('Modalidade', 'Presencial'),
                          ]),
                          const SizedBox(height: 20),
                          _sectionTitle('Observações'),
                          const SizedBox(height: 10),
                          Container(
                            height: 110,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F6FA),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFDCE2EA)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _sectionTitle('Checklist'),
                          const SizedBox(height: 10),
                          ...List.generate(
                            6,
                            (index) => Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F6FA),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: const Color(0xFFDCE2EA)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _primaryColor,
                            side: const BorderSide(color: Color(0xFFC9D2DF)),
                            minimumSize: const Size(108, 46),
                          ),
                          child: const Text('Fechar'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _accentColor,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(180, 46),
                          ),
                          child: const Text('Iniciar Atendimento'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: _primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _infoGrid(List<Widget> children) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: children,
    );
  }

  Widget _fieldBox(String label, String value) {
    return SizedBox(
      width: 290,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F6FA),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFDCE2EA)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Color(0xFF7B8798), fontSize: 12),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: _textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Consultas da Semana',
          style: TextStyle(
            color: _primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Row(
          children: [
            _buildSideMenu(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1180),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _panelColor,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFD3DCE5)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x100F172A),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: 210,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            const itemWidth = 190.0;
                            const spacing = 12.0;
                            final totalWidth =
                                (_weekDays.length * itemWidth) + ((_weekDays.length - 1) * spacing);

                            Widget buildDayCard(int index) {
                              final day = _weekDays[index];
                              final isToday = day.day == _todayDayNumber;
                              final appointments = _appointmentsByDay[day.day] ?? const [];

                              return Container(
                                width: itemWidth,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isToday ? _accentColor : const Color(0xFFD3DCE5),
                                    width: isToday ? 2 : 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isToday ? _accentColor : const Color(0xFFF8FAFC),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            day.label,
                                            style: const TextStyle(
                                              color: _primaryColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            day.day,
                                            style: const TextStyle(
                                              color: _primaryColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 28,
                                              height: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: appointments.isEmpty
                                            ? const Center(
                                                child: Text(
                                                  'Sem pacientes',
                                                  style: TextStyle(
                                                    color: Color(0xFF8B92A1),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )
                                            : ListView.separated(
                                                itemCount: appointments.length,
                                              separatorBuilder: (_, separatorIndex) =>
                                                const SizedBox(height: 6),
                                                itemBuilder: (context, itemIndex) {
                                                  final patient = appointments[itemIndex];

                                                  return InkWell(
                                                    borderRadius: BorderRadius.circular(10),
                                                    onTap: () => _showPatientDialog(patient),
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 6,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: const Color(0xFFF8FAFC),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 14,
                                                            backgroundColor: const Color(0xFFE0E6EE),
                                                            child: Text(
                                                              patient.name.substring(0, 1),
                                                              style: const TextStyle(
                                                                color: _primaryColor,
                                                                fontWeight: FontWeight.w700,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 8),
                                                          Expanded(
                                                            child: Text(
                                                              patient.name,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: const TextStyle(
                                                                color: _textColor,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            if (constraints.maxWidth > totalWidth) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var i = 0; i < _weekDays.length; i++) ...[
                                    if (i > 0) const SizedBox(width: spacing),
                                    buildDayCard(i),
                                  ],
                                ],
                              );
                            }

                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _weekDays.length,
                              separatorBuilder: (_, separatorIndex) =>
                                  const SizedBox(width: spacing),
                              itemBuilder: (context, index) => buildDayCard(index),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
