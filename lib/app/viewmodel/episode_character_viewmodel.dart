import 'package:flutter/widgets.dart';

import '../locator.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';

class EpisodeCharacterViewModel extends ChangeNotifier {
  final _apiService = locator<ApiService>();
  List<Character>? characterList = [];

  void getEpisodeCharacters(List<String> charactersUrl) async {
    final idList = charactersUrl
        .map((element) => int.parse(element.split("/").last))
        .toList();
    characterList = await _apiService.getMultipleCharacters(idList);
    notifyListeners();
  }

  void clearCharacterList() {
    characterList = [];
    notifyListeners();
  }
}
