import 'package:ai_repository/ai_repository.dart';
import 'package:article_repository/article_repository.dart';
import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:firebase_notifications_client/firebase_notifications_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_ai_client/gemini_ai_client.dart';
import 'package:lumo/app/app.dart';
import 'package:lumo/main/bootstrap/bootstrap.dart';
import 'package:lumo/src/version.dart';
import 'package:lumo_api/client.dart';
import 'package:news_repository/news_repository.dart';
import 'package:notifications_repository/notifications_repository.dart';
import 'package:package_info_client/package_info_client.dart';
import 'package:permission_client/permission_client.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:token_storage/token_storage.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(
    (
      firebaseMessaging,
      sharedPreferences,
      analyticsRepository,
    ) async {
      final tokenStorage = InMemoryTokenStorage();

      final apiClient = LumoApiClient.localhost(
        tokenProvider: tokenStorage.readToken,
      );

      const permissionClient = PermissionClient();

      final persistentStorage = PersistentStorage(
        sharedPreferences: sharedPreferences,
      );

      final packageInfoClient = PackageInfoClient(
        appName: 'Lumo [DEV]',
        packageName: 'com.lumo.app.dev',
        packageVersion: packageVersion,
      );
/*
        final deepLinkService = DeepLinkService(
          deepLinkClient: FirebaseDeepLinkClient(
            firebaseDynamicLinks: firebaseDynamicLinks,
          ),
        );
*/
      final userStorage = UserStorage(storage: persistentStorage);

      final authenticationClient = FirebaseAuthenticationClient(
        tokenStorage: tokenStorage,
      );

      final notificationsClient = FirebaseNotificationsClient(
        firebaseMessaging: firebaseMessaging,
      );

      final userRepository = UserRepository(
        apiClient: apiClient,
        authenticationClient: authenticationClient,
        packageInfoClient: packageInfoClient,
        //  deepLinkService: deepLinkService,
        storage: userStorage,
      );

      final newsRepository = NewsRepository(
        apiClient: apiClient,
      );

      final notificationsRepository = NotificationsRepository(
        permissionClient: permissionClient,
        storage: NotificationsStorage(storage: persistentStorage),
        notificationsClient: notificationsClient,
        apiClient: apiClient,
      );

      final articleRepository = ArticleRepository(
        storage: ArticleStorage(storage: persistentStorage),
        apiClient: apiClient,
      );

      // AI Repository setup
      final aiClient = GeminiAIClient(
        apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
        modelName: dotenv.env['GEMINI_MODEL'] ?? 'gemini-1.5-flash',
      );

      final aiRepository = AIRepository(
        client: aiClient,
        storage: ConversationStorage(storage: persistentStorage),
      );

      return App(
        userRepository: userRepository,
        newsRepository: newsRepository,
        notificationsRepository: notificationsRepository,
        articleRepository: articleRepository,
        analyticsRepository: analyticsRepository,
        aiRepository: aiRepository,
        user: await userRepository.user.first,
      );
    },
  );
}
