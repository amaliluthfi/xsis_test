import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xsis_test/core/router/app_route.dart';
import 'package:xsis_test/core/router/route_constant.dart';

import 'module/home/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Netplix',
      initialRoute: RouteConstant.home,
      getPages: AppRoute.all,
      home: const MyHomePage(),
    );
  }
}
