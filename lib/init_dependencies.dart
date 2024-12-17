import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

import './core/secrets/app_database_secrets.dart';
import './features/auth/data/datasources/auth_remote_data_source.dart';
import './features/auth/data/repository/auth_repository_impl.dart';
import './features/auth/domin/repository/auth_repository.dart';
import './features/auth/domin/usecases/user_sign_up_usecase.dart';
import './features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  final supabase = await Supabase.initialize(
    url: AppDatabaseSecrets.supabaseUrl,
    anonKey: AppDatabaseSecrets.supabaseAnonKey,
  );

  sl.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  // Remote Data Source
  sl
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(supabaseClient: sl()),
    )

    // Data Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl()),
    )

    // Usecase
    ..registerFactory(
      () => UserSignUpUsecase(authRepository: sl()),
    )

    // AuthBloc
    ..registerLazySingleton(
      () => AuthBloc(userSignUpUsecase: sl()),
    );
}
