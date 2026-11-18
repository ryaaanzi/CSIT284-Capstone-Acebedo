
import 'package:flutter/material.dart';
import '../models/clinic_visit.dart';
import '../widgets/visit_card.dart';

class NurseQueueScreen extends StatefulWidget {
  final List<ClinicVisit> visits;

  const NurseQueueScreen({
    super.key,
    required this.visits,
  });

  @override
  State<NurseQueueScreen> createState() => _NurseQueueScreenState();
}

class _NurseQueueScreenState extends State<NurseQueueScreen> {
  void markAsAttended(ClinicVisit visit) {
    setState(() {
      visit.attended = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final waitingVisits =
        widget.visits.where((visit) => !visit.attended).toList();

    final attendedVisits =
        widget.visits.where((visit) => visit.attended).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nurse Queue'),
        centerTitle: true,
      ),
      body: Column(
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
                        onAttended: () => markAsAttended(visit),
                      );
                    },
                  ),
          ),
        ],
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
