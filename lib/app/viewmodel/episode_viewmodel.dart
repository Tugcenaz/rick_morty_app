import 'package:flutter/material.dart';
import 'package:rick_morty_app/app/models/episode_model.dart';

import '../locator.dart';
import '../services/api_service.dart';

class EpisodeViewModel extends ChangeNotifier {
  final _apiService = locator<ApiService>();
  EpisodeModel? episodeModel;
  int nextPage = 1;

  Future<void> getAllEpisodes() async {
    episodeModel = await _apiService.getAllEpisodes(params: {"page": nextPage});
    if (nextPage != episodeModel!.info!.count) nextPage++;
    notifyListeners();
  }
}
