import 'package:bloc/bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.dashboard);

  void setTab(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return emit(HomeState.dashboard);
      case 1:
        return emit(HomeState.habits);
      case 2:
        return emit(HomeState.aiChat);
      case 3:
        return emit(HomeState.profile);
    }
  }
}
