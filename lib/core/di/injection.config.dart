// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/datasources/auth_remote_data_source_http.dart'
    as _i827;
import '../../features/auth/data/datasources/auth_remote_data_source_mock.dart'
    as _i954;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/check_auth_use_case.dart' as _i594;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/domain/usecases/logout_use_case.dart' as _i711;
import '../../features/auth/presentation/blocs/auth_bloc.dart' as _i85;
import '../../features/wellness_packages/data/datasources/wellness_package_remote_data_source.dart'
    as _i320;
import '../../features/wellness_packages/data/datasources/wellness_package_remote_data_source_http.dart'
    as _i819;
import '../../features/wellness_packages/data/datasources/wellness_package_remote_data_source_mock.dart'
    as _i37;
import '../../features/wellness_packages/data/repositories/wellness_package_repository_impl.dart'
    as _i143;
import '../../features/wellness_packages/domain/repositories/wellness_package_repository.dart'
    as _i472;
import '../../features/wellness_packages/domain/usecases/get_wellness_packages_use_case.dart'
    as _i419;
import '../../features/wellness_packages/presentation/blocs/wellness_packages_bloc.dart'
    as _i1018;
import '../errors/error_handler.dart' as _i433;
import '../l10n/locale_cubit.dart' as _i171;
import '../network/connectivity_service.dart' as _i491;
import '../network/dio_client.dart' as _i667;
import '../network/interceptors/auth_interceptor.dart' as _i745;
import '../network/interceptors/error_interceptor.dart' as _i511;
import '../network/interceptors/logging_interceptor.dart' as _i344;
import '../storage/hive_storage_service.dart' as _i131;
import '../storage/local_storage_service.dart' as _i744;
import '../storage/preferences_service.dart' as _i636;
import '../storage/secure_storage_service.dart' as _i666;

const String _dev = 'dev';
const String _test = 'test';
const String _staging = 'staging';
const String _production = 'production';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i511.ErrorInterceptor>(() => const _i511.ErrorInterceptor());
    gh.factory<_i344.LoggingInterceptor>(
        () => const _i344.LoggingInterceptor());
    gh.singleton<_i433.ErrorHandler>(() => const _i433.ErrorHandler());
    gh.lazySingleton<_i491.ConnectivityService>(
        () => _i491.ConnectivityService());
    gh.lazySingleton<_i131.HiveStorageService>(
        () => _i131.HiveStorageService());
    gh.lazySingleton<_i636.PreferencesService>(
        () => _i636.PreferencesService());
    gh.lazySingleton<_i320.WellnessPackageRemoteDataSource>(
      () => const _i37.WellnessPackageRemoteDataSourceMock(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i107.AuthRemoteDataSource>(
      () => const _i954.AuthRemoteDataSourceMock(),
      registerFor: {_test},
    );
    gh.factory<_i171.LocaleCubit>(
        () => _i171.LocaleCubit(gh<_i636.PreferencesService>()));
    gh.lazySingleton<_i744.LocalStorageService>(
        () => _i666.SecureStorageService());
    gh.factory<_i745.AuthInterceptor>(
        () => _i745.AuthInterceptor(gh<_i744.LocalStorageService>()));
    gh.singleton<_i667.DioClient>(() => _i667.DioClient(
          gh<_i745.AuthInterceptor>(),
          gh<_i344.LoggingInterceptor>(),
          gh<_i511.ErrorInterceptor>(),
        ));
    gh.lazySingleton<_i107.AuthRemoteDataSource>(
      () => _i827.AuthRemoteDataSourceHttp(gh<_i667.DioClient>()),
      registerFor: {
        _dev,
        _staging,
        _production,
      },
    );
    gh.lazySingleton<_i787.AuthRepository>(() => _i153.AuthRepositoryImpl(
          gh<_i107.AuthRemoteDataSource>(),
          gh<_i744.LocalStorageService>(),
        ));
    gh.lazySingleton<_i320.WellnessPackageRemoteDataSource>(
      () => _i819.WellnessPackageRemoteDataSourceHttp(gh<_i667.DioClient>()),
      registerFor: {
        _staging,
        _production,
      },
    );
    gh.factory<_i594.CheckAuthUseCase>(
        () => _i594.CheckAuthUseCase(gh<_i787.AuthRepository>()));
    gh.factory<_i37.LoginUseCase>(
        () => _i37.LoginUseCase(gh<_i787.AuthRepository>()));
    gh.factory<_i711.LogoutUseCase>(
        () => _i711.LogoutUseCase(gh<_i787.AuthRepository>()));
    gh.lazySingleton<_i472.WellnessPackageRepository>(() =>
        _i143.WellnessPackageRepositoryImpl(
            gh<_i320.WellnessPackageRemoteDataSource>()));
    gh.singleton<_i85.AuthBloc>(() => _i85.AuthBloc(
          gh<_i37.LoginUseCase>(),
          gh<_i711.LogoutUseCase>(),
          gh<_i594.CheckAuthUseCase>(),
        ));
    gh.factory<_i419.GetWellnessPackagesUseCase>(() =>
        _i419.GetWellnessPackagesUseCase(
            gh<_i472.WellnessPackageRepository>()));
    gh.factory<_i1018.WellnessPackagesBloc>(() =>
        _i1018.WellnessPackagesBloc(gh<_i419.GetWellnessPackagesUseCase>()));
    return this;
  }
}
