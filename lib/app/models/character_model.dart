import 'dart:convert';

import 'info_model.dart';
CharacterModel characterModelFromJson(String str) => CharacterModel.fromJson(json.decode(str));
String characterModelToJson(CharacterModel data) => json.encode(data.toJson());
class CharacterModel {
  CharacterModel({
      this.info, 
      this.character,});

  CharacterModel.fromJson(dynamic json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      character = [];
      json['results'].forEach((v) {
        character?.add(Character.fromJson(v));
      });
    }
  }
  Info? info;
  List<Character>? character;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (info != null) {
      map['info'] = info?.toJson();
    }
    if (character != null) {
      map['results'] = character?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Character resultsFromJson(String str) => Character.fromJson(json.decode(str));
String resultsToJson(Character data) => json.encode(data.toJson());
class Character {
  Character({
      this.id, 
      this.name, 
      this.status, 
      this.species, 
      this.type, 
      this.gender, 
      this.origin, 
      this.location, 
      this.image, 
      this.episode, 
      this.url, 
      this.created,});

  Character.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    origin = json['origin'] != null ? Origin.fromJson(json['origin']) : null;
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    image = json['image'];
    episode = json['episode'] != null ? json['episode'].cast<String>() : [];
    url = json['url'];
    created = json['created'];
  }
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Origin? origin;
  Location? location;
  String? image;

  @override
  String toString() {
    return 'Character{id: $id, name: $name}';
  }

  List<String>? episode;
  String? url;
  String? created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['status'] = status;
    map['species'] = species;
    map['type'] = type;
    map['gender'] = gender;
    if (origin != null) {
      map['origin'] = origin?.toJson();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['image'] = image;
    map['episode'] = episode;
    map['url'] = url;
    map['created'] = created;
    return map;
  }

}

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());
class Location {
  Location({
      this.name, 
      this.url,});

  Location.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }
  String? name;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    return map;
  }

}

Origin originFromJson(String str) => Origin.fromJson(json.decode(str));
String originToJson(Origin data) => json.encode(data.toJson());
class Origin {
  Origin({
      this.name, 
      this.url,});

  Origin.fromJson(dynamic json) {
    name = json['name'];
    url = json['url'];
  }
  String? name;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['url'] = url;
    return map;
  }

}

