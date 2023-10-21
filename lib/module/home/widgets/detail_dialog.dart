import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xsis_test/common/models/movies_model.dart';
import 'package:xsis_test/common/widgets/landscape_loading.dart';
import 'package:xsis_test/common/widgets/spacer.dart';
import 'package:xsis_test/module/home/data/controllers/detail_controller.dart';
import 'package:xsis_test/module/home/data/controllers/home_controller.dart';
import 'package:xsis_test/module/home/widgets/movie_landscape_card.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailDialog extends StatelessWidget {
  const DetailDialog({super.key, required this.item, required this.imageUrl});

  final Result item;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return GetBuilder<DetailController>(
          init: DetailController(movieId: item.id.toString()),
          builder: (detailController) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.grey[400], shape: BoxShape.circle),
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: 18,
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          !detailController.videoToogle
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                            placeholder: (context, url) {
                                              return Container(
                                                height: 180,
                                                color: Colors.grey,
                                              );
                                            },
                                            imageUrl: imageUrl +
                                                (item.backdropPath ?? ""))),
                                    detailController.isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              detailController.videoToogle =
                                                  true;
                                              detailController.update();
                                            },
                                            icon: const Icon(
                                              Icons.play_arrow_rounded,
                                              color: Colors.white,
                                              size: 50,
                                            ))
                                  ],
                                )
                              : YoutubePlayerBuilder(
                                  player: YoutubePlayer(
                                      controller: detailController.ytController,
                                      showVideoProgressIndicator: true,
                                      progressIndicatorColor: Colors.blueAccent,
                                      topActions: <Widget>[
                                        const SpaceW8(),
                                        Expanded(
                                          child: Text(
                                            detailController
                                                .ytController.metadata.title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                      onReady: () {
                                        detailController.isPlayerReady = true;
                                        detailController.update();
                                      }),
                                  builder: (context, player) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Positioned(
                                            child: GestureDetector(
                                                onTap: () {
                                                  if (detailController
                                                      .ytController
                                                      .value
                                                      .isPlaying) {
                                                    detailController
                                                        .showButton = true;
                                                    detailController
                                                        .ytController
                                                        .pause();

                                                    detailController.update();
                                                  }
                                                },
                                                child: player),
                                          ),
                                          Positioned(
                                            child: Visibility(
                                              visible:
                                                  detailController.showButton,
                                              child: IconButton(
                                                  icon: const Icon(
                                                    Icons.play_arrow,
                                                    size: 50,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    detailController
                                                        .showButton = false;
                                                    detailController
                                                        .ytController
                                                        .play();
                                                    detailController.update();
                                                  }),
                                            ),
                                          ),
                                        ],
                                      )),
                          const SpaceH16(),
                          Text(
                            item.title ?? "",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SpaceH16(),
                          Text(
                            item.overview ?? "",
                            style: const TextStyle(),
                          ),
                        ],
                      ),
                    ),
                    controller.isLoadingLatest
                        ? const LandscapeLoading()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "Latest",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              const SpaceH8(),
                              SizedBox(
                                height: 200,
                                child: Expanded(
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
                                              Get.back();
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
                                            child: MovieLandscapeCard(
                                                item: item,
                                                imageUrl: controller.imageUrl),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            );
          });
    });
  }
}
