
import 'package:flutter/material.dart';
import 'models/clinic_visit.dart';
import 'screens/student_visit_screen.dart';
import 'screens/nurse_queue_screen.dart';

void main() {
  runApp(const ClinicVisitApp());
}

class ClinicVisitApp extends StatefulWidget {
  const ClinicVisitApp({super.key});

  @override
  State<ClinicVisitApp> createState() => _ClinicVisitAppState();
}

class _ClinicVisitAppState extends State<ClinicVisitApp> {
  int selectedIndex = 0;

  final List<ClinicVisit> visits = dummyVisits;

  @override
  Widget build(BuildContext context) {
    final screens = [
      StudentVisitScreen(visits: visits),
      NurseQueueScreen(visits: visits),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinic Visit Log',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: screens,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Student',
            ),
            NavigationDestination(
              icon: Icon(Icons.local_hospital),
              label: 'Nurse Queue',
            ),
          ],
        ),
      ),
    );
  }
}
