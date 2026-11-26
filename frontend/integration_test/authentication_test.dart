import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/main.dart' as app;

const email = String.fromEnvironment('QA_EMAIL', defaultValue: 'qa-client@example.invalid');
const password = String.fromEnvironment('QA_PASSWORD', defaultValue: 'Fixture-Only-Password!42');

Future<void> waitFor(WidgetTester tester, Finder finder) async {
  for (var i = 0; i < 120; i++) {
    await tester.pump(const Duration(milliseconds: 250));
    if (finder.evaluate().isNotEmpty) return;
  }
  fail('Widget introuvable après 30 secondes : $finder');
}

Future<void> fillLogin(WidgetTester tester, String pass) async {
  final emailField = find.byKey(const Key('qa_login_email'));
  final passwordField = find.byKey(const Key('qa_login_password'));
  final submit = find.byKey(const Key('qa_login_submit'));
  await waitFor(tester, emailField);
  await tester.enterText(emailField, email);
  await tester.enterText(passwordField, pass);
  await tester.ensureVisible(submit);
  await tester.tap(submit);
  await tester.pump();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('E2E-01 wrong password rejected; E2E-02 correct login opens home', (tester) async {
    app.main();
    await fillLogin(tester, 'Wrong-Fixture-Password');
    await waitFor(tester, find.byKey(const Key('qa_login_error')));
    expect(find.byKey(const Key('qa_home')), findsNothing);
    await fillLogin(tester, password);
    await waitFor(tester, find.byKey(const Key('qa_home')));
    expect(find.byKey(const Key('qa_home')), findsOneWidget);
  });
}
