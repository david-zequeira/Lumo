import 'package:ai_repository/ai_repository.dart';
import 'package:analytics_repository/analytics_repository.dart';
import 'package:app_ui/app_ui.dart';
import 'package:article_repository/article_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumo/analytics/analytics.dart';
import 'package:lumo/app/app.dart';
import 'package:lumo/l10n/l10n.dart';
import 'package:lumo/login/login.dart' hide LoginEvent;
import 'package:lumo/theme_selector/theme_selector.dart';
import 'package:news_repository/news_repository.dart';
import 'package:notifications_repository/notifications_repository.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required UserRepository userRepository,
    required NewsRepository newsRepository,
    required NotificationsRepository notificationsRepository,
    required ArticleRepository articleRepository,
    required AnalyticsRepository analyticsRepository,
    required AIRepository aiRepository,
    required User user,
    super.key,
  })  : _userRepository = userRepository,
        _newsRepository = newsRepository,
        _notificationsRepository = notificationsRepository,
        _articleRepository = articleRepository,
        _analyticsRepository = analyticsRepository,
        _aiRepository = aiRepository,
        _user = user;

  final UserRepository _userRepository;
  final NewsRepository _newsRepository;
  final NotificationsRepository _notificationsRepository;
  final ArticleRepository _articleRepository;
  final AnalyticsRepository _analyticsRepository;
  final AIRepository _aiRepository;
  final User _user;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _newsRepository),
        RepositoryProvider.value(value: _notificationsRepository),
        RepositoryProvider.value(value: _articleRepository),
        RepositoryProvider.value(value: _analyticsRepository),
        RepositoryProvider.value(value: _aiRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              userRepository: _userRepository,
              notificationsRepository: _notificationsRepository,
              user: _user,
            )..add(const AppOpened()),
          ),
          BlocProvider(create: (_) => ThemeModeBloc()),
          BlocProvider(
            create: (_) => LoginWithEmailLinkBloc(
              userRepository: _userRepository,
            ),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => AnalyticsBloc(
              analyticsRepository: _analyticsRepository,
              userRepository: _userRepository,
            ),
            lazy: false,
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: const AppTheme().themeData,
      darkTheme: const AppDarkTheme().themeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const _AppFlowBuilder(),
    );
  }
}

class _AppFlowBuilder extends StatelessWidget {
  const _AppFlowBuilder();

  @override
  Widget build(BuildContext context) {
    final appStatus = context.select((AppBloc bloc) => bloc.state.status);

    return AuthenticatedUserListener(
      child: FlowBuilder<AppStatus>(
        state: appStatus,
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
