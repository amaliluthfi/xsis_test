import 'dart:convert';

import 'package:xsis_test/common/models/movies_model.dart';
import 'package:xsis_test/core/network/app_network.dart';
import 'package:xsis_test/module/home/data/models/videos_model.dart';

class HomeNetwork {
  final AppNetwork _network = AppNetwork();

  Future<Movies> fetchPopularMoviesNetwork() async {
    try {
      var res = await _network.get("/movie/popular");
      return Movies.fromJson(json.decode(res));
    } catch (e) {
      rethrow;
    }
  }

  Future<Movies> fetchLatestMoviesNetwork() async {
    try {
      var res = await _network.get("/movie/now_playing");
      return Movies.fromJson(json.decode(res));
    } catch (e) {
      rethrow;
    }
  }

  Future<Movies> fetchActionMoviesNetwork() async {
    try {
      var res = await _network.get("/discover/movie?with_genres=action");
      return Movies.fromJson(json.decode(res));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Videos>> fetchVideosNetwork({required String id}) async {
    try {
      var res = await _network.get("/movie/$id/videos");
      return List<Videos>.from(
          json.decode(res)["results"].map((x) => Videos.fromJson(x)));
    } catch (e) {
      rethrow;
    }
  }
}
