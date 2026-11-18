
import 'package:flutter/material.dart';
import '../models/clinic_visit.dart';
import '../widgets/visit_card.dart';

class StudentVisitScreen extends StatefulWidget {
  final List<ClinicVisit> visits;

  const StudentVisitScreen({
    super.key,
    required this.visits,
  });

  @override
  State<StudentVisitScreen> createState() => _StudentVisitScreenState();
}

class _StudentVisitScreenState extends State<StudentVisitScreen> {
  final TextEditingController studentIdController =
      TextEditingController();

  final TextEditingController symptomController =
      TextEditingController();

  void submitVisit() {
    final studentId = studentIdController.text.trim();
    final symptom = symptomController.text.trim();

    if (studentId.isEmpty || symptom.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your student ID and symptom.'),
        ),
      );
      return;
    }

    setState(() {
      widget.visits.insert(
        0,
        ClinicVisit(
          studentId: studentId,
          symptom: symptom,
          timestamp: DateTime.now(),
        ),
      );
    });

    studentIdController.clear();
    symptomController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Clinic visit submitted successfully!'),
      ),
    );
  }

  @override
  void dispose() {
    studentIdController.dispose();
    symptomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Clinic Visit'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Log a Clinic Visit',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: studentIdController,
                        decoration: const InputDecoration(
                          labelText: 'Student ID',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.badge),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: symptomController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Describe your symptom',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.medical_services),
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: submitVisit,
                          icon: const Icon(Icons.send),
                          label: const Text('Submit Visit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Recent Clinic Visits',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...widget.visits.take(5).map(
              (visit) => VisitCard(visit: visit),
            ),
          ],
        ),
      ),
    );
  }
}
