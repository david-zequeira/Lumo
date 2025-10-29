import 'package:ai_repository/ai_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumo/ai_companion/ai_companion.dart';
import 'package:lumo/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(
          create: (context) => AiCompanionBloc(
            aiRepository: context.read<AIRepository>(),
          )..add(const AiCompanionStarted()),
        ),
      ],
      child: const HomeView(),
    );
  }
}
