
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Clinic Visit Log navigation displays correctly',
      (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: IndexedStack(
                index: selectedIndex,
                children: const [
                  Center(child: Text('Student Clinic Visit')),
                  Center(child: Text('Waiting Queue')),
                ],
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
            );
          },
        ),
      ),
    );

    expect(find.text('Student Clinic Visit'), findsOneWidget);
    expect(find.text('Student'), findsOneWidget);
    expect(find.text('Nurse Queue'), findsOneWidget);

    await tester.tap(find.text('Nurse Queue'));
    await tester.pumpAndSettle();

    expect(find.text('Waiting Queue'), findsOneWidget);
  });
}
