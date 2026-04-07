import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'about_screen.dart';
import 'appointment_registration_screen.dart';
import 'bioscore_provider.dart';
import 'login_screen.dart';
import 'patients_list_screen.dart';

class WeekDayOption {
  const WeekDayOption({required this.label, required this.day});

  final String label;
  final String day;
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

  bool _isMenuExpanded = true;

  String get _todayDayNumber => DateTime.now().day.toString().padLeft(2, '0');

  List<Appointment> _appointmentsForDay(List<Appointment> appointments, String day) {
    return appointments.where((appointment) {
      final parts = appointment.date.split('/');
      if (parts.isEmpty) {
        return false;
      }
      return parts.first.padLeft(2, '0') == day;
    }).toList();
  }

  Widget _menuItem({
    required IconData icon,
    required String label,
    bool selected = false,
    VoidCallback? onTap,
  }) {
    if (!_isMenuExpanded) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEAF2FB) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: SizedBox(
            height: 44,
            child: Center(child: Icon(icon, color: _primaryColor)),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFEAF2FB) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: _primaryColor),
        title: Text(label, style: const TextStyle(color: _textColor, fontWeight: FontWeight.w600)),
        horizontalTitleGap: 8,
        minLeadingWidth: 24,
        onTap: onTap,
      ),
    );
  }

  Widget _buildSideMenu() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: _isMenuExpanded ? 228 : 78,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFD3DCE5))),
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
                      style: TextStyle(color: _primaryColor, fontSize: 18, fontWeight: FontWeight.w700),
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
                _menuItem(
                  icon: Icons.people,
                  label: 'Pacientes',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PatientsListScreen()),
                    );
                  },
                ),
                _menuItem(
                  icon: Icons.calendar_month,
                  label: 'Nova Consulta',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AppointmentRegistrationScreen()),
                    );
                  },
                ),
                _menuItem(
                  icon: Icons.info_outline,
                  label: 'Sobre',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutScreen()),
                    );
                  },
                ),
                _menuItem(
                  icon: Icons.logout_rounded,
                  label: 'Sair',
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          const Divider(height: 1, color: Color(0xFFD3DCE5)),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
            child: Column(
              crossAxisAlignment:
                  _isMenuExpanded ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  tooltip: 'Configuracoes',
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

  @override
  Widget build(BuildContext context) {
    final appointments = context.watch<BioScoreProvider>().appointments;

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Consultas da Semana',
          style: TextStyle(color: _primaryColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Row(
          children: [
            _buildSideMenu(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
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
                          BoxShadow(color: Color(0x100F172A), blurRadius: 10, offset: Offset(0, 4)),
                        ],
                      ),
                      child: SizedBox(
                        height: 240,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            const itemWidth = 210.0;
                            const spacing = 12.0;
                            final totalWidth =
                                (_weekDays.length * itemWidth) + ((_weekDays.length - 1) * spacing);

                            Widget buildDayCard(int index) {
                              final day = _weekDays[index];
                              final isToday = day.day == _todayDayNumber;
                              final dayAppointments = _appointmentsForDay(appointments, day.day);

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
                                        child: dayAppointments.isEmpty
                                            ? const Center(
                                                child: Text(
                                                  'Nenhuma consulta agendada para este dia',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFF8B92A1),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              )
                                            : ListView.separated(
                                                itemCount: dayAppointments.length,
                                                separatorBuilder: (_, index) => const SizedBox(height: 6),
                                                itemBuilder: (context, itemIndex) {
                                                  final appointment = dayAppointments[itemIndex];

                                                  return Container(
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
                                                            appointment.patientName.substring(0, 1),
                                                            style: const TextStyle(
                                                              color: _primaryColor,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                appointment.patientName,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: const TextStyle(
                                                                  color: _textColor,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                              const SizedBox(height: 2),
                                                              Text(
                                                                '${appointment.time} - ${appointment.type}',
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: const TextStyle(
                                                                  color: Color(0xFF6B7280),
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
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
                              separatorBuilder: (_, index) => const SizedBox(width: spacing),
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
