import 'package:flutter/material.dart';
import 'package:rick_morty_app/app/locator.dart';
import 'package:rick_morty_app/app/models/favourite_character_model.dart';
import 'package:rick_morty_app/app/services/api_service.dart';
import 'package:rick_morty_app/app/services/preferences_service.dart';
import '../models/character_model.dart';

class FavouritesViewModel extends ChangeNotifier {
  final preferencesApi = locator<PreferencesService>();
  final apiService = locator<ApiService>();

  List<FavouriteCharacterModel> _favourites = [];

  List<FavouriteCharacterModel> get favourites => _favourites;

  Future<void> getFavourites() async {
    try {
      _favourites = await preferencesApi.getFavouriteCharacters();
    } catch (e) {
      _favourites = []; // Hata durumunda listeyi boş bırak
      debugPrint("Error loading favourites: $e");
    }
    notifyListeners();
  }

  Future<void> addFavouriteCharacter(Character character) async {
    final favCharacter =
        FavouriteCharacterModel(character: character, isFavourite: true);
    await preferencesApi.addFavouriteCharacter(favCharacter);
    await getFavourites();
  }

  Future<void> removeFavouriteCharacter({required int id}) async {
    await preferencesApi.removeFavouriteCharacter(id);
    await getFavourites();
  }
}
