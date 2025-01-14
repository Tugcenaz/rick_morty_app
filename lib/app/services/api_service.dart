import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rick_morty_app/app/models/character_model.dart';
import 'package:rick_morty_app/app/models/favourite_character_model.dart';

class ApiService {
  final dio = Dio(BaseOptions(
      baseUrl:
          dotenv.env['API_BASE_URL'] ?? 'https://rickandmortyapi.com/api'));

  Future clientGet(
      {required String apiPath, Map<String, dynamic>? arguments}) async {
    try {
      final response = await dio.get(apiPath, queryParameters: arguments);
      if (response.data != null) {
        return response.data;
      }
      return null;
    } on DioException catch (e) {
      return Future.error(e);
    }
  }

  Future<CharacterModel?> getAllCharacters(
      {Map<String, dynamic>? params}) async {
    try {
      final responseData =
          await clientGet(apiPath: '/character', arguments: params);

      if (responseData != null) {
        CharacterModel characterModel = CharacterModel.fromJson(responseData);

        return characterModel;
      }

      return null;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Character>?> getMultipleCharacters(
      {required List<int> idList}) async {
    try {
      final responseData =
          await clientGet(apiPath: "/character/${idList.join(',')}");
      if (responseData != null) {
        return (responseData as List)
            .map((e) => Character.fromJson(e))
            .toList();
      }
      return null;
    } catch (e) {
      return Future.error(e);
    }
  }
}
