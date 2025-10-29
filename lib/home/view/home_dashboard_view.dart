import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumo/home/helpers/emotion_l10n_helper.dart';
import 'package:lumo/home/home.dart';
import 'package:lumo/l10n/l10n.dart';

/// {@template home_dashboard_view}
/// Vista principal del dashboard de Lumo.
/// Muestra resumen de hábitos, estado emocional y acceso rápido al AI.
/// {@endtemplate}
class HomeDashboardView extends StatelessWidget {
  /// {@macro home_dashboard_view}
  const HomeDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(lumo): Obtener usuario real del AppBloc
    const userName = ''; // Temporal

    return CustomScrollView(
      slivers: [
        // Header con saludo
        SliverToBoxAdapter(
          child: GreetingHeader(
            userName: userName,
          ),
        ),

        // Contenido principal
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Check-in emocional
              EmotionCheckInCard(
                onEmotionSelected: (emotion) {
                  // TODO(lumo): Guardar emoción en repository
                  final l10n = context.l10n;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${l10n.emotionRegistered}: ${emotion.getLabel(context)}',
                      ),
                    ),
                  );
                },
                currentEmotion: null, // TODO(lumo): Obtener de estado
              ),
              const SizedBox(height: AppSpacing.lg),

              // Resumen diario de hábitos
              DailySummaryCard(
                completedHabits: 3, // TODO(lumo): Obtener de estado
                totalHabits: 5, // TODO(lumo): Obtener de estado
                onTap: () {
                  // TODO(lumo): Navegar a vista de hábitos
                  context.read<HomeCubit>().setTab(1);
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              // Acceso rápido al AI
              AIQuickAccessCard(
                onTap: () {
                  // TODO(lumo): Navegar al chat con AI
                  context.read<HomeCubit>().setTab(2);
                },
                lastMessage: null, // TODO(lumo): Último mensaje del AI
              ),
              const SizedBox(height: AppSpacing.lg),

              // Sección de hábitos recientes
              _buildHabitsSection(context),

              const SizedBox(height: AppSpacing.xlg),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildHabitsSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.todaysHabitsTitle,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<HomeCubit>().setTab(1);
              },
              child: Text(l10n.seeAllButton),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Hábitos de ejemplo
        ..._buildTemporaryHabits(context),
      ],
    );
  }

  List<Widget> _buildTemporaryHabits(BuildContext context) {
    final l10n = context.l10n;

    return [
      HabitCard(
        title: l10n.habitMeditation,
        description: l10n.habitMeditationDesc,
        icon: Icons.self_improvement,
        streak: 7,
        progress: 1.0,
        isCompleted: true,
        onTap: () {
          // TODO(lumo): Navegar a detalle del hábito
        },
      ),
      const SizedBox(height: AppSpacing.md),
      HabitCard(
        title: l10n.habitReading,
        description: l10n.habitReadingDesc,
        icon: Icons.menu_book,
        streak: 5,
        progress: 0.6,
        onTap: () {
          // TODO(lumo): Navegar a detalle del hábito
        },
      ),
      const SizedBox(height: AppSpacing.md),
      HabitCard(
        title: l10n.habitExercise,
        description: l10n.habitExerciseDesc,
        icon: Icons.fitness_center,
        streak: 3,
        onTap: () {
          // TODO(lumo): Navegar a detalle del hábito
        },
      ),
    ];
  }
}
