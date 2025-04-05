import 'package:get_it/get_it.dart';
import 'package:pets_shop/core/config/dio_config.dart';
import 'package:pets_shop/data/datasources/pet_local_datasource.dart';
import 'package:pets_shop/data/datasources/pet_remote_datasource.dart';
import 'package:pets_shop/data/repository/pet_repository_impl.dart';
import 'package:pets_shop/data/services/pets_service.dart';
import 'package:pets_shop/domain/repository/pet_repository.dart';
import 'package:pets_shop/domain/usecases/get_pets.dart';
import 'package:pets_shop/domain/usecases/search_pets.dart';
import 'package:pets_shop/presentation/bloc/pet_list_bloc.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.instance;

void initializeDependencies() {
  // Network
  getIt.registerLazySingleton<Dio>(() => DioConfig.createDio());
  getIt.registerLazySingleton<PetService>(() => PetService(getIt()));

  // Data Sources
  getIt.registerLazySingleton<IPetLocalDataSource>(
    () => PetLocalDataSource(),
  );

  getIt.registerLazySingleton<IPetRemoteDataSource>(
    () => PetRemoteDataSource(),
  );

  // Repositories
  getIt.registerLazySingleton<IPetRepository>(
    () => PetRepositoryImpl(
      localDataSource: getIt(),
      remoteDataSource: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetPetsUseCase(getIt()));
  getIt.registerLazySingleton(() => SearchPetsUseCase(getIt()));

  // BLoCs
  getIt.registerFactory(
    () => PetListBloc(
      getPetsUseCase: getIt(),
      searchPetsUseCase: getIt(),
    ),
  );
}
