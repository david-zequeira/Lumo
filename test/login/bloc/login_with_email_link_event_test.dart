// ignore_for_file: prefer_const_constructors

import 'package:user_repository/user_repository.dart';
import 'package:lumo/login/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUser extends Mock implements User {}

void main() {
  group('LoginWithEmailLinkEvent', () {
    group('LoginWithEmailLinkSubmitted', () {
      test('supports value comparisons', () {
        final user = MockUser();
        expect(
          LoginWithEmailLinkSubmitted(user),
          LoginWithEmailLinkSubmitted(user),
        );
      });
    });
  });
}
