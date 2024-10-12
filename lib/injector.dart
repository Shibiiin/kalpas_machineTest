import 'package:get_it/get_it.dart';
import 'package:kalpas/kalpas/core/api_provider.dart';
import 'package:kalpas/kalpas/data/data_sources/app_dataSource.dart';
import 'package:kalpas/kalpas/data/repositories/app_repository.dart';
import 'package:kalpas/kalpas/domain/repositories/app_repository_impl.dart';
import 'package:kalpas/kalpas/domain/use_cases/apple_useCase.dart';

final getIt = GetIt.instance;
Future<void> setUp() async {
  getIt.registerSingleton<ApiProvider>(ApiProvider());
  getIt.registerLazySingleton<AppDataSource>(() => AppDataSourceImple(getIt()));
  getIt.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(getIt()));

  getIt.registerLazySingleton<AppleUseCase>(() => AppleUseCase(getIt()));
}
