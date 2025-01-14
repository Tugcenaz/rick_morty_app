import 'dart:convert';

import 'info_model.dart';
EpisodeModel episodeModelFromJson(String str) => EpisodeModel.fromJson(json.decode(str));
String episodeModelToJson(EpisodeModel data) => json.encode(data.toJson());
class EpisodeModel {
  EpisodeModel({
      this.info, 
      this.results,});

  EpisodeModel.fromJson(dynamic json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }
  Info? info;
  List<Results>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (info != null) {
      map['info'] = info?.toJson();
    }
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));
String resultsToJson(Results data) => json.encode(data.toJson());
class Results {
  Results({
      this.id, 
      this.name, 
      this.airDate, 
      this.episode, 
      this.characters, 
      this.url, 
      this.created,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    airDate = json['air_date'];
    episode = json['episode'];
    characters = json['characters'] != null ? json['characters'].cast<String>() : [];
    url = json['url'];
    created = json['created'];
  }
  int? id;
  String? name;
  String? airDate;
  String? episode;
  List<String>? characters;
  String? url;
  String? created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['air_date'] = airDate;
    map['episode'] = episode;
    map['characters'] = characters;
    map['url'] = url;
    map['created'] = created;
    return map;
  }

}

