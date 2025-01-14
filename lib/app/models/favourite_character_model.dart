
import 'character_model.dart';

class FavouriteCharacterModel {
  Character character;

  @override
  String toString() {
    return 'FavouriteCharacterModel{character: $character, isFavourite: $isFavourite}';
  }

  bool isFavourite;

  FavouriteCharacterModel({required this.character, required this.isFavourite});

  factory FavouriteCharacterModel.fromJson(Map<String, dynamic> json) {
    return FavouriteCharacterModel(
      character: Character.fromJson(json['character']),
      isFavourite: json['isFavourite']??false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'character': character.toJson(), "isFavourite": isFavourite};
  }
}
