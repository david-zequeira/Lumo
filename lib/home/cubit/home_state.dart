part of 'home_cubit.dart';

enum HomeState {
  dashboard(0),
  habits(1),
  aiChat(2),
  profile(3);

  const HomeState(this.tabIndex);
  final int tabIndex;
}
