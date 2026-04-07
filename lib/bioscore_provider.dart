import 'dart:collection';

import 'package:flutter/foundation.dart';

class Patient {
  const Patient({
    required this.name,
    required this.cpf,
    required this.goal,
  });

  final String name;
  final String cpf;
  final String goal;
}

class Appointment {
  const Appointment({
    required this.patientName,
    required this.date,
    required this.time,
    required this.type,
  });

  final String patientName;
  final String date;
  final String time;
  final String type;
}

class BioScoreProvider extends ChangeNotifier {
  final List<Patient> _patients = [
    const Patient(
      name: 'Carlos Mendonca',
      cpf: '111.222.333-44',
      goal: 'Emagrecimento',
    ),
    const Patient(
      name: 'Ana Beatriz Lima',
      cpf: '555.666.777-88',
      goal: 'Hipertrofia',
    ),
  ];

  final List<Appointment> _appointments = [
    const Appointment(
      patientName: 'Carlos Mendonca',
      date: '06/04/2026',
      time: '08:00',
      type: 'Primeira Consulta',
    ),
    const Appointment(
      patientName: 'Ana Beatriz Lima',
      date: '08/04/2026',
      time: '10:30',
      type: 'Retorno',
    ),
  ];

  UnmodifiableListView<Patient> get patients => UnmodifiableListView(_patients);

  UnmodifiableListView<Appointment> get appointments => UnmodifiableListView(_appointments);

  void addPatient(Patient patient) {
    _patients.add(patient);
    notifyListeners();
  }

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  void deletePatient(Patient patient) {
    _patients.remove(patient);
    _appointments.removeWhere((appointment) => appointment.patientName == patient.name);
    notifyListeners();
  }
}
