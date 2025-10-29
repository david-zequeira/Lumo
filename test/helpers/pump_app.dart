import 'package:article_repository/article_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:lumo/analytics/analytics.dart';
import 'package:lumo/app/app.dart';
import 'package:lumo/l10n/l10n.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lumo/l10n/arb/app_localizations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_repository/news_repository.dart';
import 'package:notifications_repository/notifications_repository.dart';
import 'package:user_repository/user_repository.dart';

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {
  @override
  AppState get state => const AppState.unauthenticated();
}

class MockAnalyticsBloc extends MockBloc<AnalyticsEvent, AnalyticsState>
    implements AnalyticsBloc {}

class MockUserRepository extends Mock implements UserRepository {
  @override
  Stream<Uri> get incomingEmailLinks => const Stream.empty();

  @override
  Stream<User> get user => const Stream.empty();
}

class MockNewsRepository extends Mock implements NewsRepository {}

class MockNotificationsRepository extends Mock
    implements NotificationsRepository {}

class MockArticleRepository extends Mock implements ArticleRepository {
  @override
  Future<ArticleViews> fetchArticleViews() async => ArticleViews(0, null);

  @override
  Future<void> incrementArticleViews() async {}

  @override
  Future<void> resetArticleViews() async {}
}

extension AppTester on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    AppBloc? appBloc,
    UserRepository? userRepository,
    NewsRepository? newsRepository,
    NotificationsRepository? notificationRepository,
    TargetPlatform? platform,
    NavigatorObserver? navigatorObserver,
    MockNavigator? navigator,
    ThemeData? theme,
  }) async {
    await pumpWidget(
      MaterialApp(
        theme: theme,
        title: 'Lumo',
        localizationsDelegates: [AppLocalizations.delegate],
        home: Theme(
          data: ThemeData(platform: platform),
          child: navigator == null
              ? Scaffold(body: widgetUnderTest)
              : MockNavigatorProvider(
                  navigator: navigator,
                  child: Scaffold(body: widgetUnderTest),
                ),
        ),
      ),
    );

    await pump();
  }
}
