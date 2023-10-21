import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xsis_test/module/home/data/controllers/home_network.dart';
import 'package:xsis_test/module/home/data/models/videos_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailController extends GetxController {
  // PostData postData = PostData();
  final String movieId;
  late YoutubePlayerController ytController;
  late TextEditingController idController;
  late TextEditingController seekToController;
  bool videoToogle = false;
  bool isPlayerReady = false;
  bool isLoading = false;
  List<Videos> videos = [];
  String videoKey = "";
  final HomeNetwork _network = HomeNetwork();
  bool showButton = true;
  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;

  DetailController({required this.movieId});

  @override
  void onInit() async {
    await fetchVideos();
    ytController = YoutubePlayerController(
      initialVideoId: videoKey,
      flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
          hideControls: true),
    )..addListener(listener);

    videoMetaData = const YoutubeMetaData();
    playerState = PlayerState.unknown;
    super.onInit();
  }

  @override
  void dispose() {
    ytController.dispose();
    idController.dispose();
    seekToController.dispose();
    super.dispose();
  }

  void listener() {
    if (isPlayerReady && !ytController.value.isFullScreen) {
      playerState = ytController.value.playerState;
      videoMetaData = ytController.metadata;
    }
  }

  Future<void> fetchVideos() async {
    isLoading = true;
    update();
    try {
      var res = await _network.fetchVideosNetwork(id: movieId);
      videos.addAll(res);
      List<Videos> video =
          videos.where((element) => element.type == Type.TRAILER).toList();

      if (video.isNotEmpty) {
        videoKey = video.first.key ?? "";
      }
    } catch (e) {
      rethrow;
    }
    isLoading = false;
    update();
  }
}
