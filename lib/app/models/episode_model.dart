import 'dart:convert';

import 'info_model.dart';

EpisodeModel episodeModelFromJson(String str) =>
    EpisodeModel.fromJson(json.decode(str));

String episodeModelToJson(EpisodeModel data) => json.encode(data.toJson());

class EpisodeModel {
  EpisodeModel({
    this.info,
    this.episode,
  });

  EpisodeModel.fromJson(dynamic json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      episode = [];
      json['results'].forEach((v) {
        episode?.add(Episode.fromJson(v));
      });
    }
  }

  Info? info;
  List<Episode>? episode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (info != null) {
      map['info'] = info?.toJson();
    }
    if (episode != null) {
      map['results'] = episode?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Episode resultsFromJson(String str) => Episode.fromJson(json.decode(str));

String resultsToJson(Episode data) => json.encode(data.toJson());

class Episode {
  Episode({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.url,
    this.created,
  });

  Episode.fromJson(dynamic json) {
    final episodeString = json['episode'] as String;
    final episodeList = episodeString.replaceAll('S', '').split('E');
    id = json['id'];
    name = json['name'];
    airDate = json['air_date'];
    episode =
        "Sezon ${int.parse(episodeList.first)} Bölüm ${int.parse(episodeList.last)}";
    characters =
        json['characters'] != null ? json['characters'].cast<String>() : [];
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
