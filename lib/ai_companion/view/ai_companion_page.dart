import 'package:ai_repository/ai_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumo/ai_companion/ai_companion.dart';

/// {@template ai_companion_page}
/// Page wrapper for AI Companion chat.
/// {@endtemplate}
class AiCompanionPage extends StatelessWidget {
  /// {@macro ai_companion_page}
  const AiCompanionPage({super.key});

  /// Route for navigation
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const AiCompanionPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiCompanionBloc(
        aiRepository: context.read<AIRepository>(),
      )..add(const AiCompanionStarted()),
      child: const AiCompanionView(),
    );
  }
}
