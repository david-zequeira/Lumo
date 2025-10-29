import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumo/ai_companion/ai_companion.dart';
import 'package:lumo/app/app.dart';
import 'package:lumo/home/home.dart';
import 'package:lumo/l10n/l10n.dart';
import 'package:lumo/login/login.dart';
import 'package:lumo/navigation/navigation.dart';
import 'package:lumo/user_profile/user_profile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab =
        context.select((HomeCubit cubit) => cubit.state.tabIndex);

    return MultiBlocListener(
      listeners: [
        BlocListener<AppBloc, AppState>(
          listenWhen: (previous, current) =>
              previous.showLoginOverlay != current.showLoginOverlay,
          listener: (context, state) {
            if (state.showLoginOverlay) {
              showAppModal<void>(
                context: context,
                builder: (context) => const LoginModal(),
                routeSettings: const RouteSettings(name: LoginModal.name),
              );
            }
          },
        ),
        BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white, // Debug: Asegurar fondo blanco
        appBar: selectedTab != 3
            ? AppBar(
                backgroundColor: AppColors.white,
                elevation: 0,
                title: AppLogo.dark(),
                centerTitle: true,
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: AppColors.black),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              )
            : null,
        drawer: const NavDrawer(),
        body: IndexedStack(
          index: selectedTab,
          children: const [
            HomeDashboardView(),
            _HabitsPlaceholder(),
            AiCompanionView(),
            UserProfilePage(),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: selectedTab,
          onTap: (value) => context.read<HomeCubit>().setTab(value),
        ),
      ),
    );
  }
}

/// Placeholder temporal para la vista de Hábitos
class _HabitsPlaceholder extends StatelessWidget {
  const _HabitsPlaceholder();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 80,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.habitsViewTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.comingSoon,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
