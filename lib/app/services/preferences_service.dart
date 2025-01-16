import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  SharedPreferences prefs;

  PreferencesService({required this.prefs});

  final String characterKey = "character";

  Future<void> storeCharacter(List<String> characters) async {
    await prefs.setStringList(characterKey, characters);
  }

  void saveCharacter(int id) async {
    List<String> charactersList = prefs.getStringList(characterKey) ?? [];
    charactersList.add(id.toString());
    await storeCharacter(charactersList);
  }

  List<int> getSavedCharacters() {
    final List<String> charactersList = prefs.getStringList(characterKey) ?? [];
    final List<int> idList =
        charactersList.map((character) => int.parse(character)).toList();
    return idList;
  }

  void removeCharacter(int id) async {
    final List<String> charactersList = prefs.getStringList(characterKey) ?? [];
    charactersList.remove(id.toString());

    await storeCharacter(charactersList);
  }
}
