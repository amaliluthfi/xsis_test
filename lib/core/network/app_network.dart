import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppNetwork {
  final String apiKey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MGZiNjE2MjFjYTk1NzljNzU5NDcyMTYyZTM0MGJkMCIsInN1YiI6IjYwMjVlYjYxOWQyYjYzMDAzZjY4MWUzMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EHbgE6HOp06aAUmdPVxu7zjGngZFxXl_p-6MiJM1Pxk";
  final String apiURL = "https://api.themoviedb.org/3";

  Future get(String? section) async {
    try {
      Uri uri = Uri.parse(apiURL + (section ?? ""));
      var res = await http.get(uri, headers: {
        "Authorization": "Bearer $apiKey",
        "accept": "application/json"
      });
      if (res.statusCode == 200) {
        return res.body;
      } else {
        throw res.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
