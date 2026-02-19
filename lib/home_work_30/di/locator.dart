//  // Тут выполняются пункты:
// register ApiClient / Repository / UseCase
// 2 реализации сервиса и переключение debug/release
// async init (SharedPreferences) ДО runApp

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_config.dart';
import '../data/api_client.dart';
import '../data/repository.dart';
import '../dom/usecase.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Важно: если в тестах/горячей перезагрузке вызываешь повторно
  if (getIt.isRegistered<AppConfig>()) {
    await getIt.reset(dispose: false);
  }

  // 1) async init до runApp
  final prefs = await SharedPreferences.getInstance();

  // флаг можно хранить и в prefs, но по заданию — debug/release
  final config = AppConfig(
    isRealApi: AppConfig.defaultIsRealApi(),
    prefs: prefs,
  );
  getIt.registerSingleton<AppConfig>(config);

  // 2) ApiClient: Mock/Real по флагу
  getIt.registerLazySingleton<ApiClient>(() {
    final cfg = getIt<AppConfig>();
    return cfg.isRealApi ? RealApiClient() : MockApiClient();
  });

  // 3) Repository
  getIt.registerLazySingleton<GroceryRepository>(
    () => GroceryRepositoryImpl(getIt<ApiClient>()),
  );

  // 4) UseCase
  getIt.registerFactory<GetGroceriesUseCase>(
    () => GetGroceriesUseCase(getIt<GroceryRepository>()),
  );
}
