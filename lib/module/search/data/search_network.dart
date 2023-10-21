import 'dart:convert';

import 'package:xsis_test/common/models/movies_model.dart';
import 'package:xsis_test/core/network/app_network.dart';

class SearchNetwork {
  final AppNetwork _network = AppNetwork();

  Future<Movies> fetchSearchMovies({String? query, String? page}) async {
    try {
      var res = await _network
          .get("/search/movie?query=${query ?? ""}&page=${page ?? "1"}");
      return Movies.fromJson(json.decode(res));
    } catch (e) {
      rethrow;
    }
  }
}
