
import 'package:flutter/material.dart';
import '../models/clinic_visit.dart';

class VisitCard extends StatelessWidget {
  final ClinicVisit visit;
  final VoidCallback? onAttended;

  const VisitCard({
    super.key,
    required this.visit,
    this.onAttended,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              visit.studentId,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text('Symptom: ${visit.symptom}'),
            const SizedBox(height: 6),
            Text(
              'Submitted: ${visit.timestamp.toLocal()}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    visit.attended ? 'Attended' : 'Waiting',
                  ),
                  backgroundColor: visit.attended
                      ? Colors.green.shade100
                      : Colors.orange.shade100,
                ),
                if (onAttended != null && !visit.attended)
                  TextButton(
                    onPressed: onAttended,
                    child: const Text('Mark Attended'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
