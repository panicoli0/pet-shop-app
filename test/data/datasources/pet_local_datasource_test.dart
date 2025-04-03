import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pets_shop/data/datasources/pet_local_datasource.dart';
import 'package:pets_shop/data/repository/pet_repository_impl.dart';
import 'package:pets_shop/domain/entities_DTOs/pet_entity.dart';

class MockPetLocalDataSource extends Mock implements IPetLocalDataSource {}

void main() {
  late PetRepositoryImpl repository;
  late MockPetLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockPetLocalDataSource();
    repository = PetRepositoryImpl(
      localDataSource: mockLocalDataSource,
    );
  });

  test('should get pets from local source when cache is available', () async {
    // Arrange
    final cachedPets = [
      PetEntity(id: 1, name: 'Test', breed: 'Test', age: 1, imageUrl: 'test')
    ];
    when(() => mockLocalDataSource.getPets())
        .thenAnswer((_) async => cachedPets);

    // Act
    final result = await repository.getPets();

    // Assert
    expect(result, equals(cachedPets));
    verify(() => mockLocalDataSource.getPets()).called(1);
    verifyNever(() => mockLocalDataSource.cachePets(any()));
  });
}
