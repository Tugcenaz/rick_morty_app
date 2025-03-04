import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rick_morty_app/app/models/character_model.dart';
import 'package:rick_morty_app/app/models/episode_model.dart';
import 'package:rick_morty_app/app/models/location_model.dart';

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
      if (idList.isEmpty) {
        return null;
      }
      final response = await clientGet(apiPath: "/character/$idList");
      if (response != null) {
        final List<Character> list = (response.data as List)
            .map((toElement) => Character.fromJson(toElement))
            .toList();
        return list;
      }
      return null;
    } catch (e) {
      return Future.error("Error: ${e.toString()} ");
    }
  }

  List<int> episodeIdList = [];

  Future<List<Episode>?> getMultipleEpisode(List<String> episodeUrl) async {
    try {
      final episodeNumber =
          episodeUrl.map((element) => element.split("/").last).toList();
      episodeIdList = episodeNumber.map((e) => int.parse(e)).toList();

      final response = await clientGet(apiPath: "/episode/$episodeIdList");
      if (response != null) {
        final List<Episode> episodeList = (response.data as List)
            .map((element) => Episode.fromJson(element))
            .toList();
        return episodeList;
      }
      return null;
    } catch (e) {
      return Future.error("Error: ${e.toString()} ");
    }
  }

  Future<LocationModel?> getLocations({Map<String, dynamic>? params}) async {
    try {
      final response = await clientGet(apiPath: '/location', arguments: params);
      if (response != null) {
        LocationModel locationModel = LocationModel.fromJson(response.data);
        return locationModel;
      }
      return null;
    } catch (e) {
      return Future.error("Error: ${e.toString()} ");
    }
  }

  Future<EpisodeModel?> getAllEpisodes({Map<String, dynamic>? params}) async {
    try {
      final response = await clientGet(apiPath: '/episode', arguments: params);
      if (response != null) {
        final episodeModel = EpisodeModel.fromJson(response.data);
        return episodeModel;
      }
      return null;
    } catch (e) {
      return Future.error("Error: ${e.toString()} ");
    }
  }
}
