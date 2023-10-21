import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xsis_test/common/models/movies_model.dart';

class MovieLandscapeCard extends StatelessWidget {
  const MovieLandscapeCard(
      {super.key, required this.item, required this.imageUrl});

  final Result item;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
                width: 20,
                placeholder: (context, url) {
                  return Container(
                    height: 180,
                    color: Colors.grey,
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    height: 180,
                    color: Colors.grey,
                    child: const Icon(Icons.image_not_supported),
                  );
                },
                imageUrl: imageUrl + (item.backdropPath ?? "")),
          ),
        ),
        Positioned.fill(
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black87,
                    Colors.black45,
                    Colors.black26,
                    Colors.black12,
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
