import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_advanced_course/app/app_prefs.dart';
import 'package:flutter_advanced_course/data/data_source/remote_data_source.dart';
import 'package:flutter_advanced_course/data/network/app_api.dart';
import 'package:flutter_advanced_course/data/network/dio_factory.dart';
import 'package:flutter_advanced_course/data/network/network_info.dart';
import 'package:flutter_advanced_course/data/repository/repository_impl.dart';
import 'package:flutter_advanced_course/domain/repository/repository.dart';
import 'package:flutter_advanced_course/domain/usecase/login_usecase.dart';
import 'package:flutter_advanced_course/presentation/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(instance<SharedPreferences>()));

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
