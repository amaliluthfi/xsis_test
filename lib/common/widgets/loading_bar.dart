import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingBar extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  const LoadingBar({
    Key? key,
    this.color,
    this.height,
    this.width,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade200,
      child: Container(
        width: width,
        height: height ?? 20,
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(radius ?? 8),
        ),
      ),
    );
  }
}
