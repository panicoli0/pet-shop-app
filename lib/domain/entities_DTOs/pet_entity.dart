class PetEntity {
  final int id;
  final String? name;
  final String? breed;
  final int? age;
  final String? imageUrl;

  const PetEntity({
    required this.id,
    this.name,
    this.breed,
    this.age,
    this.imageUrl,
  });

  // Add copyWith method for immutability
  PetEntity copyWith({
    int? id,
    String? name,
    String? breed,
    int? age,
    String? imageUrl,
  }) {
    return PetEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  // Add a factory method to fetch complete pet details
  static Future<PetEntity> getFullPetDetails(int id) async {
    // This would typically fetch from your repository
    // For now, return a mock
    return PetEntity(
      id: id,
      name: 'Loading...',
      breed: 'Loading...',
      age: 0,
      imageUrl: '',
    );
  }
}
