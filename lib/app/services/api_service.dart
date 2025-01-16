import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rick_morty_app/app/models/character_model.dart';

class ApiService {
  final dio = Dio(BaseOptions(
      baseUrl:
          dotenv.env['API_BASE_URL'] ?? 'https://rickandmortyapi.com/api'));

  Future<Response<dynamic>?> clientGet(
      {required String apiPath, Map<String, dynamic>? arguments}) async {
    try {
      final response = await dio.get(apiPath, queryParameters: arguments);
      if (response.data != null) {
        return response;
      }
      return null;
    } on DioException catch (e) {
      return Future.error(e);
    }
  }

  Future<CharacterModel?> getAllCharacters(
      {Map<String, dynamic>? params}) async {
    try {
      final response =
          await clientGet(apiPath: '/character', arguments: params);

      if (response != null) {
        CharacterModel characterModel = CharacterModel.fromJson(response.data);

        return characterModel;
      }
      return null;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Character>?> getMultipleCharacters(List<int> idList) async {
    try {
      if(idList.isEmpty){
        return null;
      }
      final response = await clientGet(apiPath: "/character/$idList");
      if (response != null) {
        final List<Character> list = (response.data as List)
            .map((toElement) => Character.fromJson(toElement))
            .toList();
        print(list);
        return list;
      }
      return null;
    } catch (e) {
      return Future.error("Error: ${e.toString()} haahaaa");
    }
  }
}
