import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:pets_shop/presentation/bloc/pet_list_bloc.dart';
import 'package:pets_shop/presentation/bloc/pet_list_event.dart';
import 'package:pets_shop/presentation/bloc/pet_list_state.dart';
import 'package:pets_shop/domain/models/pet.dart';
import 'package:pets_shop/data/repository/pet_repository.dart';

class MockPetRepository extends Mock implements IPetRepository {}

void main() {
  group('PetListBloc Tests', () {
    late PetListBloc bloc;
    late MockPetRepository mockRepository;

    // Test data
    final testPets = [
      Pet(
        name: 'Buddy',
        breed: 'Golden Retriever',
        age: 3,
        imageUrl: 'resources/images/buddy2.jpeg',
      ),
      Pet(
        name: 'Whiskers',
        breed: 'Siamese',
        age: 2,
        imageUrl: 'resources/images/cat1.jpeg',
      ),
    ];

    setUp(() {
      mockRepository = MockPetRepository();
      bloc = PetListBloc(repository: mockRepository);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is PetListInitial', () {
      expect(bloc.state, isA<PetListInitial>());
    });

    blocTest<PetListBloc, PetListState>(
      'emits [Loading, Loaded] states when pets are loaded successfully',
      build: () {
        when(() => mockRepository.getPets()).thenAnswer((_) async => testPets);
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
      'emits [Loading, Error] states when loading fails',
      build: () {
        when(() => mockRepository.getPets())
            .thenThrow(Exception('Network error'));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadPets()),
      expect: () => [
        isA<PetListLoading>(),
        isA<PetListError>().having(
          (state) => (state).message,
          'error message',
          contains('Network error'),
        ),
      ],
    );

    blocTest<PetListBloc, PetListState>(
      'filters pets by breed correctly',
      seed: () => PetListLoaded(testPets),
      build: () => bloc,
      act: (bloc) => bloc.add(FilterPetsByBreed('Siamese')),
      expect: () => [
        isA<PetListLoaded>().having(
          (state) => (state).pets,
          'filtered pets',
          equals([testPets[1]]),
        ),
      ],
    );

    blocTest<PetListBloc, PetListState>(
      'searches pets by name correctly',
      seed: () => PetListLoaded(testPets),
      build: () => bloc,
      act: (bloc) => bloc.add(SearchPets('Buddy')),
      expect: () => [
        isA<PetListLoaded>().having(
          (state) => (state).pets,
          'searched pets',
          equals([testPets[0]]),
        ),
      ],
    );

    blocTest<PetListBloc, PetListState>(
      'adds new pet correctly',
      seed: () => PetListLoaded(testPets),
      build: () => bloc,
      act: (bloc) => bloc.add(
        AddPet(
          Pet(
            name: 'Max',
            breed: 'Labrador',
            age: 1,
            imageUrl: 'resources/images/max.jpeg',
          ),
        ),
      ),
      expect: () => [
        isA<PetListLoaded>().having(
          (state) => (state).pets.length,
          'pets length',
          equals(3),
        ),
      ],
    );
  });
}
