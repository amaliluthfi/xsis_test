import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xsis_test/common/models/movies_model.dart';
import 'package:xsis_test/module/search/data/search_network.dart';

class SearchMoviesController extends GetxController {
  final SearchNetwork _network = SearchNetwork();
  List<Result> searchResult = [];
  TextEditingController seacrhTxt = TextEditingController(text: "");
  bool isLoading = false;
  final imageUrl = "https://www.themoviedb.org/t/p/original";
  late ScrollController scrollController = ScrollController();
  Timer? debounce;
  int page = 1;
  bool isLoadingMore = false;

  @override
  void onInit() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.extentAfter == 0) {
          loadmore();
        }
      });
    searchMovies();
    super.onInit();
  }

  searchMovies() async {
    page = 1;
    isLoading = true;
    update();
    try {
      var res = await _network.fetchSearchMovies(query: seacrhTxt.text);
      searchResult = res.results ?? [];
      page++;
    } catch (e) {
      rethrow;
    }
    isLoading = false;
    update();
  }

  searchOnChange() async {
    try {
      if (debounce?.isActive ?? false) debounce!.cancel();
      debounce = Timer(const Duration(seconds: 1), () async {
        await searchMovies();
      });
    } catch (e) {
      rethrow;
    }
  }

  loadmore() async {
    if (!isLoadingMore) {
      isLoadingMore = true;
      update();
      try {
        var res = await _network.fetchSearchMovies(
            query: seacrhTxt.text, page: page.toString());
        searchResult.addAll(res.results ?? []);
        page++;
      } catch (e) {
        rethrow;
      }
      isLoadingMore = false;
      update();
    }
  }
}
