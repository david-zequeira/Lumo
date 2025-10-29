// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumo/app/app.dart';
import 'package:lumo/home/home.dart';
import 'package:lumo/login/login.dart';
import 'package:lumo/navigation/navigation.dart';
import 'package:lumo/user_profile/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

class MockAppBloc extends Mock implements AppBloc {}

void main() {
  initMockHydratedStorage();

  late HomeCubit cubit;
  late AppBloc appBloc;

  setUp(() {
    cubit = MockHomeCubit();
    appBloc = MockAppBloc();

    when(() => appBloc.state).thenReturn(
      AppState(
        showLoginOverlay: false,
        status: AppStatus.unauthenticated,
      ),
    );

    when(() => cubit.state).thenReturn(HomeState.dashboard);
  });
  group('HomeView', () {
    testWidgets('renders AppBar with AppLogo', (tester) async {
      when(() => cubit.state).thenReturn(HomeState.dashboard);

      await pumpHomeView(
        tester: tester,
        cubit: cubit,
      );

      expect(
        find.byWidgetPredicate(
          (widget) => widget is AppBar && widget.title is AppLogo,
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'renders NavDrawer '
        'when menu icon is tapped', (tester) async {
      when(() => cubit.state).thenReturn(HomeState.dashboard);

      await pumpHomeView(
        tester: tester,
        cubit: cubit,
      );

      expect(find.byType(NavDrawer), findsNothing);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pump();

      expect(find.byType(NavDrawer), findsOneWidget);
    });

    testWidgets('renders HomeDashboardView by default', (tester) async {
      when(() => cubit.state).thenReturn(HomeState.dashboard);

      await pumpHomeView(
        tester: tester,
        cubit: cubit,
      );

      expect(find.byType(HomeDashboardView), findsOneWidget);
    });

    testWidgets('shows LoginOverlay when showLoginOverlay is true',
        (tester) async {
      whenListen(
        appBloc,
        Stream.fromIterable([
          AppState(status: AppStatus.unauthenticated, showLoginOverlay: false),
          AppState(status: AppStatus.unauthenticated, showLoginOverlay: true),
        ]),
      );

      await pumpHomeView(
        tester: tester,
        cubit: cubit,
        appBloc: appBloc,
      );

      expect(find.byType(LoginModal), findsOneWidget);
    });
  });

  group('BottomNavigationBar', () {
    testWidgets(
      'has selected index to 0 by default.',
      (tester) async {
        when(() => cubit.state).thenReturn(HomeState.dashboard);

        await pumpHomeView(
          tester: tester,
          cubit: cubit,
        );

        expect(find.byType(HomeDashboardView), findsOneWidget);
      },
    );

    testWidgets(
      'set tab to selected index 0 when dashboard is tapped.',
      (tester) async {
        await pumpHomeView(
          tester: tester,
          cubit: cubit,
        );
        await tester.ensureVisible(find.byType(BottomNavBar));
        await tester.tap(find.byIcon(Icons.home_outlined));
        verify(() => cubit.setTab(0)).called(1);
      },
    );

    testWidgets(
      'set tab to selected index 1 when habits is tapped.',
      (tester) async {
        await pumpHomeView(
          tester: tester,
          cubit: cubit,
        );
        await tester.ensureVisible(find.byType(BottomNavBar));
        await tester.tap(find.byIcon(Icons.check_circle_outline));
        verify(() => cubit.setTab(1)).called(1);
      },
    );

    testWidgets(
      'unfocuses keyboard when tab is changed.',
      (tester) async {
        final controller = StreamController<HomeState>();
        whenListen(
          cubit,
          controller.stream,
          initialState: HomeState.dashboard,
        );
        await pumpHomeView(
          tester: tester,
          cubit: cubit,
        );

        await tester.ensureVisible(find.byType(BottomNavBar));
        await tester.tap(find.byIcon(Icons.check_circle_outline));
        verify(() => cubit.setTab(1)).called(1);

        controller.add(HomeState.habits);
        await tester.pump();

        // Verify focus manager behavior
        expect(
          tester.binding.focusManager.primaryFocus,
          isNull, // No focus after tab change
        );
      },
    );
  });
}

Future<void> pumpHomeView({
  required WidgetTester tester,
  required HomeCubit cubit,
  AppBloc? appBloc,
}) async {
  await tester.pumpApp(
    BlocProvider.value(
      value: cubit,
      child: HomeView(),
    ),
    appBloc: appBloc,
  );
}
