import 'package:flutter/material.dart';

import '../locator.dart';
import '../models/character_model.dart';
import '../models/location_model.dart';
import '../services/api_service.dart';

class LocationViewModel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  LocationModel? _locationModel;

  LocationModel? get locationModel => _locationModel;

  int nextPage = 1;

  Future<void> getLocations() async {
    _locationModel = await _apiService.getLocations(params: {"page": nextPage});

    if (nextPage != _locationModel!.info!.count) nextPage++;
    notifyListeners();
  }
}
