import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:pets_shop/domain/usecases/get_pets.dart';
import 'package:pets_shop/domain/usecases/search_pets.dart';
import 'package:pets_shop/presentation/bloc/pet_list_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_event.dart';
import 'package:pets_shop/presentation/bloc/pet_list_state.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

class MockGetPetsUseCase extends Mock implements GetPetsUseCase {}

class MockSearchPetsUseCase extends Mock implements SearchPetsUseCase {}

void main() {
  late PetListBloc bloc;
  late MockGetPetsUseCase mockGetPetsUseCase;
  late MockSearchPetsUseCase mockSearchPetsUseCase;

  setUp(() {
    mockGetPetsUseCase = MockGetPetsUseCase();
    mockSearchPetsUseCase = MockSearchPetsUseCase();
    bloc = PetListBloc(
      getPetsUseCase: mockGetPetsUseCase,
      searchPetsUseCase: mockSearchPetsUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('PetListBloc', () {
    final testPets = [
      PetEntity(
        id: 1,
        name: 'Test Pet',
        breed: 'Test Breed',
        age: 1,
        imageUrl: 'test.jpg',
      ),
    ];

    test('initial state is PetListInitial', () {
      expect(bloc.state, isA<PetListInitial>());
    });

    blocTest<PetListBloc, PetListState>(
      'emits [Loading, Loaded] when LoadPets is successful',
      build: () {
        when(() => mockGetPetsUseCase()).thenAnswer((_) async => testPets);
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPets()),
      expect: () => [
        isA<PetListLoading>(),
        isA<PetListLoaded>().having(
          (state) => (state).pets,
          'pets',
          equals(testPets),
        ),
      ],
    );

    blocTest<PetListBloc, PetListState>(
      'emits [Loading, Error] when LoadPets fails',
      build: () {
        when(() => mockGetPetsUseCase())
            .thenThrow(Exception('Failed to load pets'));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPets()),
      expect: () => [
        isA<PetListLoading>(),
        isA<PetListError>().having(
          (state) => (state).message,
          'error message',
          contains('Failed to load pets'),
        ),
      ],
    );

    blocTest<PetListBloc, PetListState>(
      'emits [Loading, Loaded] when SearchPets is successful',
      build: () {
        when(() => mockSearchPetsUseCase(any()))
            .thenAnswer((_) async => testPets);
        return bloc;
      },
      act: (bloc) => bloc.add(SearchPets('Test')),
      expect: () => [
        isA<PetListLoading>(),
        isA<PetListLoaded>().having(
          (state) => (state).pets,
          'pets',
          equals(testPets),
        ),
      ],
    );

    blocTest<PetListBloc, PetListState>(
      'emits [Loading, Error] when SearchPets fails',
      build: () {
        when(() => mockSearchPetsUseCase(any()))
            .thenThrow(Exception('Failed to search pets'));
        return bloc;
      },
      act: (bloc) => bloc.add(SearchPets('Test')),
      expect: () => [
        isA<PetListLoading>(),
        isA<PetListError>().having(
          (state) => (state).message,
          'error message',
          contains('Failed to search pets'),
        ),
      ],
    );

    blocTest<PetListBloc, PetListState>(
      'filters pets by breed correctly',
      seed: () => PetListLoaded(testPets),
      build: () => bloc,
      act: (bloc) => bloc.add(FilterPetsByBreed('Test Breed')),
      expect: () => [
        isA<PetListLoaded>().having(
          (state) => (state).pets,
          'filtered pets',
          equals(testPets),
        ),
      ],
    );

    blocTest<PetListBloc, PetListState>(
      'adds new pet correctly',
      seed: () => PetListLoaded(testPets),
      build: () => bloc,
      act: (bloc) => bloc.add(
        AddPet(
          PetEntity(
            id: 2,
            name: 'New Pet',
            breed: 'New Breed',
            age: 2,
            imageUrl: 'new.jpg',
          ),
        ),
      ),
      expect: () => [
        isA<PetListLoaded>().having(
          (state) => (state).pets.length,
          'pets length',
          equals(2),
        ),
      ],
    );
  });
}
