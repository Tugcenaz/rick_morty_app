import 'package:flutter/material.dart';
import 'package:rick_morty_app/app/models/character_model.dart';
import 'package:rick_morty_app/app/services/api_service.dart';

import '../locator.dart';

class CharactersViewModel extends ChangeNotifier {
  CharacterModel? _characterModel;


  CharacterModel? get characterModel => _characterModel;
  final _apiService = locator<ApiService>();
  int nextPage = 1;

  Future<void> getCharacters() async {
    _characterModel = await _apiService.getAllCharacters(params: {"page": nextPage});

    if (nextPage != _characterModel!.info!.count) nextPage++;
    notifyListeners();
  }

  void clearCharacter() {
    _characterModel = null;
    nextPage = 1;
    notifyListeners();
  }

  Future<void> getSearchCharacters({required String name}) async {
    clearCharacter();
    _characterModel = await _apiService.getAllCharacters(params: {"name": name});

    notifyListeners();
  }

}
