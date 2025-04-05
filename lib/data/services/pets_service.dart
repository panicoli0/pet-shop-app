import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:pets_shop/data/models/pet_model.dart';

part 'pets_service.g.dart';

@RestApi(baseUrl: 'https://api.petshop.com')
abstract class PetService {
  factory PetService(Dio dio) = _PetService;

  @GET('/pets')
  Future<List<PetModel>> getPets();

  @GET('/pets/search')
  Future<List<PetModel>> searchPets(@Query('query') String query);

  @POST('/pets')
  Future<PetModel> addPet(@Body() PetModel pet);
}
