import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xsis_test/common/models/movies_model.dart';
import 'package:xsis_test/common/widgets/landscape_loading.dart';
import 'package:xsis_test/common/widgets/loading_bar.dart';
import 'package:xsis_test/common/widgets/spacer.dart';
import 'package:xsis_test/core/router/route_constant.dart';
import 'package:xsis_test/core/style/app_colors.dart';
import 'package:xsis_test/module/home/data/controllers/home_controller.dart';
import 'package:xsis_test/module/home/widgets/detail_dialog.dart';
import 'package:xsis_test/module/home/widgets/movie_carousel_card.dart';
import 'package:xsis_test/module/home/widgets/movie_landscape_card.dart';
import 'package:xsis_test/module/home/widgets/movie_portrait._card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: AppColors.bgColor,
              appBar: AppBar(
                leading: const Icon(Icons.list_rounded),
                backgroundColor: AppColors.primaryColor,
                title: const Text(
                  "Netplix",
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  IconButton(
                      onPressed: () => Get.toNamed(RouteConstant.search),
                      icon: const Icon(Icons.search_rounded))
                ],
              ),
              body: SingleChildScrollView(
                child: Column(children: [
                  controller.isLoadingPopular
                      ? const LandscapeLoading()
                      : Column(
                          children: [
                            CarouselSlider.builder(
                                carouselController:
                                    controller.carouselController,
                                itemCount: controller.popularMovies
                                    .sublist(0, 5)
                                    .length,
                                itemBuilder: (context, index, idx) {
                                  Result item = controller.popularMovies[index];
                                  return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          showAdaptiveDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  insetPadding:
                                                      const EdgeInsets.all(16),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: DetailDialog(
                                                    item: item,
                                                    imageUrl:
                                                        controller.imageUrl,
                                                  ),
                                                );
                                              });
                                        },
                                        child: MovieCarouselCard(
                                          item: item,
                                          imageUrl: controller.imageUrl,
                                        ),
                                      ));
                                },
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    controller.setCarouselIndex(index);
                                  },
                                  aspectRatio: 16 / 9,
                                  autoPlay: true,
                                )),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    controller.popularMovies
                                        .sublist(0, 5)
                                        .length,
                                    (index) => Container(
                                        width: 10,
                                        height: 10,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: controller.carouselIndex ==
                                                    index
                                                ? AppColors.secondaryColor
                                                : Colors.grey[300],
                                            shape: BoxShape.circle))))
                          ],
                        ),
                  controller.isLoadingLatest
                      ? const LandscapeLoading()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Latest",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800),
                              ),
                            ),
                            const SpaceH8(),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: controller.latestMovies.length,
                                  itemBuilder: (context, index) {
                                    Result item =
                                        controller.latestMovies[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          showAdaptiveDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  insetPadding:
                                                      const EdgeInsets.all(16),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: DetailDialog(
                                                    item: item,
                                                    imageUrl:
                                                        controller.imageUrl,
                                                  ),
                                                );
                                              });
                                        },
                                        child: MovieLandscapeCard(
                                            item: item,
                                            imageUrl: controller.imageUrl),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                  controller.isLoadingAction
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: LoadingBar(
                            width: 280,
                            height: 400,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Action",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800),
                              ),
                            ),
                            const SpaceH8(),
                            SizedBox(
                              height: 300,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: controller.actionMovies.length,
                                  itemBuilder: (context, index) {
                                    Result item =
                                        controller.actionMovies[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () => Dialog(
                                          insetPadding:
                                              const EdgeInsets.all(16),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: DetailDialog(
                                            item: item,
                                            imageUrl: controller.imageUrl,
                                          ),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            showAdaptiveDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    insetPadding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                    child: DetailDialog(
                                                      item: item,
                                                      imageUrl:
                                                          controller.imageUrl,
                                                    ),
                                                  );
                                                });
                                          },
                                          child: MoviePortraitCard(
                                              item: item,
                                              imageUrl: controller.imageUrl),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )
                ]),
              ));
        });
  }
}
