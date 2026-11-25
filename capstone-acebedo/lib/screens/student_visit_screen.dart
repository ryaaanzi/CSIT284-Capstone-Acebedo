
import 'package:flutter/material.dart';

import '../models/clinic_visit.dart';
import '../services/firestore_service.dart';
import '../widgets/visit_card.dart';

class StudentVisitScreen extends StatefulWidget {
  const StudentVisitScreen({super.key});

  @override
  State<StudentVisitScreen> createState() => _StudentVisitScreenState();
}

class _StudentVisitScreenState extends State<StudentVisitScreen> {
  final TextEditingController studentIdController =
      TextEditingController();

  final TextEditingController symptomController =
      TextEditingController();

  final FirestoreService firestoreService = FirestoreService();

  bool isSubmitting = false;

  Future<void> submitVisit() async {
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
      isSubmitting = true;
    });

    try {
      final visit = ClinicVisit(
        studentId: studentId,
        symptom: symptom,
        timestamp: DateTime.now(),
      );

      await firestoreService.addVisit(visit);

      if (!mounted) return;

      studentIdController.clear();
      symptomController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Clinic visit submitted successfully!'),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to submit visit: $error'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
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
                        style: Theme.of(context).textTheme.titleLarge,
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
                          onPressed: isSubmitting ? null : submitVisit,
                          icon: isSubmitting
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.send),
                          label: Text(
                            isSubmitting ? 'Submitting...' : 'Submit Visit',
                          ),
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
            StreamBuilder<List<ClinicVisit>>(
              stream: firestoreService.getVisits(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Unable to load clinic visits.'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final visits = snapshot.data ?? [];

                if (visits.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No clinic visits recorded yet.'),
                  );
                }

                return Column(
                  children: visits.take(5).map(
                    (visit) => VisitCard(visit: visit),
                  ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
