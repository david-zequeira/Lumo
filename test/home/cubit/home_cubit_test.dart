import 'package:bloc_test/bloc_test.dart';
import 'package:lumo/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeCubit', () {
    group('constructor', () {
      test('has correct initial state', () async {
        expect(
          HomeCubit().state,
          equals(HomeState.dashboard),
        );
      });
    });

    group('setTab', () {
      blocTest<HomeCubit, HomeState>(
        'sets tab on dashboard',
        build: HomeCubit.new,
        act: (cubit) => cubit.setTab(0),
        expect: () => [
          HomeState.dashboard,
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'sets tab on habits',
        build: HomeCubit.new,
        act: (cubit) => cubit.setTab(1),
        expect: () => [
          HomeState.habits,
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'sets tab on aiChat',
        build: HomeCubit.new,
        act: (cubit) => cubit.setTab(2),
        expect: () => [
          HomeState.aiChat,
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'sets tab on profile',
        build: HomeCubit.new,
        act: (cubit) => cubit.setTab(3),
        expect: () => [
          HomeState.profile,
        ],
      );
    });
  });
}
