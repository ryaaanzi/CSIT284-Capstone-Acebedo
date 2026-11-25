
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screens/student_visit_screen.dart';
import 'screens/nurse_queue_screen.dart';

import 'models/clinic_visit.dart';
import 'services/firestore_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirestoreService().seedDummyVisits(dummyVisits);

  runApp(const ClinicVisitApp());
}

class ClinicVisitApp extends StatefulWidget {
  const ClinicVisitApp({super.key});

  @override
  State<ClinicVisitApp> createState() => _ClinicVisitAppState();
}

class _ClinicVisitAppState extends State<ClinicVisitApp> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const StudentVisitScreen(),
      const NurseQueueScreen(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinic Visit Log',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
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
