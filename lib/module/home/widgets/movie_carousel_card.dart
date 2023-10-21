import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xsis_test/common/models/movies_model.dart';
import 'package:xsis_test/core/style/app_colors.dart';

class MovieCarouselCard extends StatelessWidget {
  const MovieCarouselCard(
      {super.key, required this.item, required this.imageUrl});

  final Result item;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.secondaryColor),
        child: Row(
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
                  errorWidget: (context, url, error) {
                    return Container(
                      height: 180,
                      color: Colors.grey,
                      child: const Icon(Icons.image_not_supported_rounded),
                    );
                  },
                  imageUrl: imageUrl + (item.posterPath ?? "")),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    item.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    item.overview ?? "",
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
