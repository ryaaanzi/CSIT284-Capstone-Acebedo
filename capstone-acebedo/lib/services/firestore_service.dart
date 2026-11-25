
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/clinic_visit.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> _visits =
      FirebaseFirestore.instance.collection('clinic_visits');

  // CREATE: Add a new clinic visit.
  Future<void> addVisit(ClinicVisit visit) async {
    await _visits.add(visit.toMap());
  }

  // READ: Listen to all clinic visits in real time.
  Stream<List<ClinicVisit>> getVisits() {
    return _visits
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ClinicVisit.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  // UPDATE: Mark a clinic visit as attended.
  Future<void> markAsAttended(String id) async {
    await _visits.doc(id).update({
      'attended': true,
    });
  }

  // DELETE: Remove a clinic visit.
  Future<void> deleteVisit(String id) async {
    await _visits.doc(id).delete();
  }

  // Add the ten sample records once for initial testing.
  Future<void> seedDummyVisits(List<ClinicVisit> visits) async {
    final snapshot = await _visits.limit(1).get();

    if (snapshot.docs.isNotEmpty) return;

    final batch = FirebaseFirestore.instance.batch();

    for (final visit in visits) {
      final document = _visits.doc();
      batch.set(document, visit.toMap());
    }

    await batch.commit();
  }
}
