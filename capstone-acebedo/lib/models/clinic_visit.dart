
class ClinicVisit {
  final String studentId;
  final String symptom;
  final DateTime timestamp;
  bool attended;

  ClinicVisit({
    required this.studentId,
    required this.symptom,
    required this.timestamp,
    this.attended = false,
  });
}

final List<ClinicVisit> dummyVisits = [
  ClinicVisit(
    studentId: '2026-001',
    symptom: 'Headache',
    timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
  ),
  ClinicVisit(
    studentId: '2026-002',
    symptom: 'Stomach ache',
    timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
  ),
  ClinicVisit(
    studentId: '2026-003',
    symptom: 'Dizziness',
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
  ClinicVisit(
    studentId: '2026-004',
    symptom: 'Cough and cold',
    timestamp: DateTime.now().subtract(const Duration(minutes: 40)),
  ),
  ClinicVisit(
    studentId: '2026-005',
    symptom: 'Fever',
    timestamp: DateTime.now().subtract(const Duration(minutes: 50)),
  ),
  ClinicVisit(
    studentId: '2026-006',
    symptom: 'Sore throat',
    timestamp: DateTime.now().subtract(const Duration(minutes: 60)),
  ),
  ClinicVisit(
    studentId: '2026-007',
    symptom: 'Minor cut',
    timestamp: DateTime.now().subtract(const Duration(minutes: 70)),
  ),
  ClinicVisit(
    studentId: '2026-008',
    symptom: 'Toothache',
    timestamp: DateTime.now().subtract(const Duration(minutes: 80)),
  ),
  ClinicVisit(
    studentId: '2026-009',
    symptom: 'Allergies',
    timestamp: DateTime.now().subtract(const Duration(minutes: 90)),
  ),
  ClinicVisit(
    studentId: '2026-010',
    symptom: 'Muscle pain',
    timestamp: DateTime.now().subtract(const Duration(minutes: 100)),
  ),
];
