import 'package:flutter/material.dart';
import 'package:rick_morty_app/app/locator.dart';
import 'package:rick_morty_app/app/services/api_service.dart';
import 'package:rick_morty_app/app/services/preferences_service.dart';
import '../models/character_model.dart';

class FavouritesViewModel extends ChangeNotifier {
  final preferencesApi = locator<PreferencesService>();
  final apiService = locator<ApiService>();
  List<int> savedCharacters = [];
  List<Character>? favouriteCharacters = [];


  void getSavedCharacter() async {
    savedCharacters = preferencesApi.getSavedCharacters();
    getMultipleCharacters();
  }

  void getMultipleCharacters() async {
    favouriteCharacters =
        await apiService.getMultipleCharacters(savedCharacters);

    notifyListeners();
  }

  void saveCharacter(int id) {
    preferencesApi.saveCharacter(id);
    getSavedCharacter();
    notifyListeners();
  }

  void removeCharacter(int id) {
    preferencesApi.removeCharacter(id);
    getSavedCharacter();
    notifyListeners();
  }
}
