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
  static const Color _primaryColor = Color(0xFF1A365D);
  static const Color _accentColor = Color(0xFF2D9CDB);
  static const Color _backgroundColor = Color(0xFFF8F9FA);
  static const Color _textColor = Color(0xFF2B2D42);

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

  String get _todayDayNumber => DateTime.now().day.toString().padLeft(2, '0');

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
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: ListView(
            children: const [
              ListTile(
                leading: Icon(Icons.person_outline),
                title: Text('Perfil'),
              ),
              ListTile(
                leading: Icon(Icons.settings_outlined),
                title: Text('Configurações'),
              ),
              ListTile(
                leading: Icon(Icons.logout_rounded),
                title: Text('Sair'),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Agendas da Semana',
                    style: TextStyle(
                      color: _primaryColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 210,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _weekDays.length,
                      itemBuilder: (context, index) {
                        final day = _weekDays[index];
                        final isToday = day.day == _todayDayNumber;
                        final appointments = _appointmentsByDay[day.day] ?? const [];

                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            width: 190,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isToday ? _accentColor : const Color(0xFFDCE2EA),
                                width: isToday ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isToday ? _accentColor : const Color(0xFFF2F4F7),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        day.label,
                                        style: TextStyle(
                                          color: isToday ? Colors.white : _primaryColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        day.day,
                                        style: TextStyle(
                                          color: isToday ? Colors.white : _primaryColor,
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
                                          separatorBuilder: (_, index) =>
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
                                                    color: const Color(0xFFF4F6FA),
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 14,
                                                        backgroundColor: const Color(0xFFE0E5EE),
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
