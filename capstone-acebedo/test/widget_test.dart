// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_acebedo/main.dart';

void main() {
  testWidgets('Clinic Visit Log displays navigation screens',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ClinicVisitApp());

    expect(find.text('Student Clinic Visit'), findsOneWidget);
    expect(find.text('Student'), findsOneWidget);
    expect(find.text('Nurse Queue'), findsOneWidget);

    await tester.tap(find.text('Nurse Queue'));
    await tester.pumpAndSettle();

    expect(find.text('Waiting Queue'), findsOneWidget);
  });
}

