import 'dart:convert';

EpisodeModel episodeModelFromJson(String str) =>
    EpisodeModel.fromJson(json.decode(str));

String episodeModelToJson(EpisodeModel data) => json.encode(data.toJson());

class EpisodeModel {
  EpisodeModel({
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.url,
    this.created,
  });

  EpisodeModel.fromJson(dynamic json) {
    final episodeString = json['episode'] as String;
    final episodeList = episodeString.replaceAll('S', '').split('E');
    id = json['id'];
    name = json['name'];
    airDate = json['air_date'];
    episode =
        'Sezon ${int.parse(episodeList.first)} Bölüm ${int.parse(episodeList.last)}';
    characters =
        json['characters'] != null ? json['characters'].cast<String>() : [];
    url = json['url'];
    created = json['created'];
  }

  int? id;
  String? name;
  String? airDate;

  @override
  String toString() {
    return 'EpisodeModel{id: $id, name: $name, airDate: $airDate, episode: $episode, characters: $characters, url: $url, created: $created}';
  }

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
