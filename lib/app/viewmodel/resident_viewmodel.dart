import 'package:flutter/cupertino.dart';

import '../locator.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';

class ResidentViewModel extends ChangeNotifier {
  final _apiService = locator<ApiService>();
  List<Character>? residentCharacters = [];

  void getResidents(List<String> residents) async {
    final list = residents.map((element) => element.split('/').last).toList();
    final List<int> idList = list.map((element) => int.parse(element)).toList();
    residentCharacters = await _apiService.getMultipleCharacters(idList);

    notifyListeners();
  }

  void clearResidents() {
    residentCharacters = [];
    notifyListeners();
  }
}
