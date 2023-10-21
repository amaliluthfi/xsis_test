import 'package:flutter/material.dart';
import 'package:xsis_test/common/widgets/loading_bar.dart';

class LandscapeLoading extends StatelessWidget {
  const LandscapeLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: LoadingBar(
        width: 400,
        height: 180,
      ),
    );
  }
}