
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicVisit {
  final String? id;
  final String studentId;
  final String symptom;
  final DateTime timestamp;
  bool attended;

  ClinicVisit({
    this.id,
    required this.studentId,
    required this.symptom,
    required this.timestamp,
    this.attended = false,
  });

  // Convert a clinic visit into Firestore data.
  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'symptom': symptom,
      'timestamp': Timestamp.fromDate(timestamp),
      'attended': attended,
    };
  }

  // Convert Firestore data into a clinic visit.
  factory ClinicVisit.fromMap(
    String documentId,
    Map<String, dynamic> data,
  ) {
    return ClinicVisit(
      id: documentId,
      studentId: data['studentId'] ?? '',
      symptom: data['symptom'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      attended: data['attended'] ?? false,
    );
  }
}

// Ten sample records for initial database testing.
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
