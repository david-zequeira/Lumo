import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumo/theme_selector/theme_selector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockThemeModeBloc extends MockBloc<ThemeModeEvent, ThemeMode>
    implements ThemeModeBloc {}

void main() {
  late ThemeModeBloc themeModeBloc;

  group('ThemeSelector', () {
    setUp(() {
      themeModeBloc = MockThemeModeBloc();
      when(() => themeModeBloc.state).thenReturn(ThemeMode.system);
    });

    testWidgets('contains all three ThemeMode options', (tester) async {
      await tester.pumpApp(BlocProvider.value(
          value: themeModeBloc, child: const ThemeSelector()));
    });

    testWidgets('sets the new ThemeMode on change', (tester) async {
      await tester.pumpApp(BlocProvider.value(
          value: themeModeBloc, child: const ThemeSelector()));
    });
  });
}
