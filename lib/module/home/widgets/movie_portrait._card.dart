import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xsis_test/common/models/movies_model.dart';

class MoviePortraitCard extends StatelessWidget {
  const MoviePortraitCard(
      {super.key, required this.item, required this.imageUrl});

  final Result item;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
                fit: BoxFit.fill,
                // width: 100,
                placeholder: (context, url) {
                  return Container(
                    height: 329,
                    color: Colors.grey,
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    height: 329,
                    color: Colors.grey,
                    child: const Icon(Icons.image_not_supported),
                  );
                },
                imageUrl: imageUrl + (item.posterPath ?? "")),
          ),
        ),
        Positioned.fill(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black45,
                    Colors.black38,
                    Colors.black12,
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0)
                  ],
                )),
            child: Text(
              item.title ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }
}
