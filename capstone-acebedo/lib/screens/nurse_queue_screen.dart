
import 'package:flutter/material.dart';

import '../models/clinic_visit.dart';
import '../services/firestore_service.dart';
import '../widgets/visit_card.dart';

class NurseQueueScreen extends StatelessWidget {
  const NurseQueueScreen({super.key});

  static final FirestoreService firestoreService = FirestoreService();

  Future<void> markAsAttended(ClinicVisit visit) async {
    if (visit.id == null) return;

    await firestoreService.markAsAttended(visit.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nurse Queue'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ClinicVisit>>(
        stream: firestoreService.getVisits(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Unable to load clinic queue.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final visits = snapshot.data ?? [];

          final waitingVisits =
              visits.where((visit) => !visit.attended).toList();

          final attendedVisits =
              visits.where((visit) => visit.attended).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildCountCard(
                        'Waiting',
                        waitingVisits.length,
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildCountCard(
                        'Attended',
                        attendedVisits.length,
                        Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Waiting Queue',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: waitingVisits.isEmpty
                    ? const Center(
                        child: Text('No students in the waiting queue.'),
                      )
                    : ListView.builder(
                        itemCount: waitingVisits.length,
                        itemBuilder: (context, index) {
                          final visit = waitingVisits[index];

                        return VisitCard(
  visit: visit,
  onAttended: () async {
    try {
      await markAsAttended(visit);
    } catch (error) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to update visit: $error'),
        ),
      );
    }
  },
  onDelete: () async {
    if (visit.id == null) return;

    try {
      await firestoreService.deleteVisit(visit.id!);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Clinic visit deleted successfully.'),
        ),
      );
    } catch (error) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to delete visit: $error'),
        ),
      );
    }
  },
);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCountCard(
    String title,
    int count,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
