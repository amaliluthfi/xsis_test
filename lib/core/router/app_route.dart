import 'package:get/get.dart';
import 'package:xsis_test/core/router/route_constant.dart';
import 'package:xsis_test/module/home/screens/home_screen.dart';
import 'package:xsis_test/module/search/screen/search_screen.dart';

class AppRoute {
  static final all = [
    GetPage(name: RouteConstant.home, page: () => const MyHomePage()),
    GetPage(name: RouteConstant.search, page: () => const SearchScreen())
  ];
}
