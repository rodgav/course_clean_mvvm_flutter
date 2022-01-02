import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:juliaca_store0/app/app_prefs.dart';
import 'package:juliaca_store0/data/data_source/local_data_source.dart';
import 'package:juliaca_store0/data/data_source/remote_data_source.dart';
import 'package:juliaca_store0/data/network/app_api.dart';
import 'package:juliaca_store0/data/network/dio_factory.dart';
import 'package:juliaca_store0/data/network/network_info.dart';
import 'package:juliaca_store0/data/repository/repository_impl.dart';
import 'package:juliaca_store0/domain/repository/repository.dart';
import 'package:juliaca_store0/domain/usecase/forgot_password_usecase.dart';
import 'package:juliaca_store0/domain/usecase/home_usecase.dart';
import 'package:juliaca_store0/domain/usecase/login_usecase.dart';
import 'package:juliaca_store0/domain/usecase/register_usecase.dart';
import 'package:juliaca_store0/domain/usecase/store_details_usecase.dart';
import 'package:juliaca_store0/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:juliaca_store0/presentation/login/login_viewmodel.dart';
import 'package:juliaca_store0/presentation/main/home/home_viewmodel.dart';
import 'package:juliaca_store0/presentation/register/register_viewmodel.dart';
import 'package:juliaca_store0/presentation/store_details/store_details_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(
      () => NetWorkInfoImpl(InternetConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));

  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

void initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

void initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

void initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

void initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
        () => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(
        () => StoreDetailsViewModel(instance()));
  }
}

void resetAllModules() {
  instance.reset(dispose: false);
  initModule();
  initLoginModule();
  initHomeModule();
  initRegisterModule();
  initForgotPasswordModule();
  initStoreDetailsModule();
}
