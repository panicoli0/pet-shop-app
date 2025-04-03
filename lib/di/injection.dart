import 'package:get_it/get_it.dart';
import 'package:pets_shop/data/datasources/pet_local_datasource.dart';
import 'package:pets_shop/data/repository/pet_repository_impl.dart';
import 'package:pets_shop/domain/repository/pet_repository.dart';
import 'package:pets_shop/domain/usecases/get_pets.dart';
import 'package:pets_shop/domain/usecases/search_pets.dart';
import 'package:pets_shop/presentation/bloc/pet_list_bloc.dart';

final getIt = GetIt.instance;

void initializeDependencies() {
  // Data Sources
  getIt.registerLazySingleton<IPetLocalDataSource>(
    () => PetLocalDataSource(),
  );

  // Repositories
  getIt.registerLazySingleton<IPetRepository>(
    () => PetRepositoryImpl(
      localDataSource: getIt(),
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
