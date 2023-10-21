import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:xsis_test/common/models/movies_model.dart';
import 'package:xsis_test/module/home/data/controllers/home_network.dart';

class HomeController extends GetxController {
  List<Result> popularMovies = [];
  List<Result> latestMovies = [];
  List<Result> actionMovies = [];
  final HomeNetwork _network = HomeNetwork();
  final imageUrl = "https://www.themoviedb.org/t/p/original";
  bool isLoadingPopular = false;
  bool isLoadingLatest = false;
  bool isLoadingAction = false;
  CarouselController carouselController = CarouselController();
  int carouselIndex = 0;

  @override
  void onInit() async {
    fetchPopularMovies();
    fetchLatestMovies();
    fetchActionMovies();
    super.onInit();
  }

  fetchPopularMovies() async {
    isLoadingPopular = true;
    update();
    try {
      var res = await _network.fetchPopularMoviesNetwork();
      popularMovies.addAll(res.results ?? []);
    } catch (e) {
      rethrow;
    }
    isLoadingPopular = false;
    update();
  }

  fetchLatestMovies() async {
    isLoadingLatest = true;
    update();
    try {
      var res = await _network.fetchLatestMoviesNetwork();
      latestMovies.addAll(res.results ?? []);
    } catch (e) {
      rethrow;
    }
    isLoadingLatest = false;
    update();
  }

  fetchActionMovies() async {
    isLoadingAction = true;
    update();
    try {
      var res = await _network.fetchActionMoviesNetwork();
      actionMovies.addAll(res.results ?? []);
    } catch (e) {
      rethrow;
    }
    isLoadingAction = false;
    update();
  }

  setCarouselIndex(int currentIndex) {
    carouselIndex = currentIndex;
    update();
  }
}
