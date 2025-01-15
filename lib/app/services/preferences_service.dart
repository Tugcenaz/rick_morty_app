import 'dart:convert';

import 'package:rick_morty_app/app/models/favourite_character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/character_model.dart';

class PreferencesService {
  SharedPreferences prefs;

  PreferencesService({required this.prefs});

  final _favCharacterKey = "favourite_characters";

  Future<void> storeFavouriteCharacter(
      List<FavouriteCharacterModel> characterList) async {
    final List<String> jsonList =
        characterList.map((element) => jsonEncode(element.toJson())).toList();
    await prefs.setStringList(_favCharacterKey, jsonList);
  }

//jsonencode stringe çevirir
//jsondecode json a çevirir
  Future<List<FavouriteCharacterModel>> getFavouriteCharacters() async {
    final jsonList = prefs.getStringList(_favCharacterKey) ?? [];
    return jsonList
        .map((charJson) =>
            FavouriteCharacterModel.fromJson(json.decode(charJson)))
        .toList();
  }

  Future<void> addFavouriteCharacter(FavouriteCharacterModel favChar) async {
    final List<FavouriteCharacterModel> characterList =
        await getFavouriteCharacters();

    if (characterList.contains(favChar)) {
      return;
    } else {
      characterList.add(favChar);
      await storeFavouriteCharacter(characterList);
    }
  }

  Future<void> removeFavouriteCharacter(int id) async {
    final List<FavouriteCharacterModel> characterList =
        await getFavouriteCharacters();
    characterList.removeWhere((favChar) => favChar.character.id == id);
    await storeFavouriteCharacter(characterList);
  }
}
