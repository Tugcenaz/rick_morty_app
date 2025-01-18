import 'package:flutter/material.dart';
import 'package:rick_morty_app/app/models/episode_model.dart';
import 'package:rick_morty_app/app/services/api_service.dart';

import '../locator.dart';

class CharacterProfileViewmodel extends ChangeNotifier {
  final apiService = locator.get<ApiService>();
  List<EpisodeModel>? _episodes = [];
  List<EpisodeModel>? get episodes => _episodes;

  void getEpisodes(List<String> episodeUrl) async {
    _episodes = await apiService.getMultipleEpisode(episodeUrl);

    notifyListeners();
  }

  void clearEpisodes() {
    _episodes = [];
    notifyListeners();
  }
}
