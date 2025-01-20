import 'dart:convert';
import 'info_model.dart';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  LocationModel({
    this.info,
    this.location,
  });

  LocationModel.fromJson(dynamic json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      location = [];
      json['results'].forEach((v) {
        location?.add(Locations.fromJson(v));
      });
    }
  }

  Info? info;
  List<Locations>? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (info != null) {
      map['info'] = info?.toJson();
    }
    if (location != null) {
      map['results'] = location?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Locations resultsFromJson(String str) => Locations.fromJson(json.decode(str));

String resultsToJson(Locations data) => json.encode(data.toJson());

class Locations {
  Locations({
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.residents,
    this.url,
    this.created,
  });

  Locations.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    dimension = json['dimension'];
    residents =
        json['residents'] != null ? json['residents'].cast<String>() : [];
    url = json['url'];
    created = json['created'];
  }

  int? id;
  String? name;
  String? type;
  String? dimension;
  List<String>? residents;
  String? url;
  String? created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['dimension'] = dimension;
    map['residents'] = residents;
    map['url'] = url;
    map['created'] = created;
    return map;
  }
}
