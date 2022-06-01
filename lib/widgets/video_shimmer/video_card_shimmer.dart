import 'package:flutter/material.dart';
import 'shimmer.dart';

class VideoCardShimmer extends StatelessWidget {
  const VideoCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 16.0),
        AspectRatio(
          aspectRatio: 1.75,
          child: Shimmer(),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            height: 20,
            child: Shimmer(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 20,
            child: Shimmer(),
          ),
        ),
      ],
    );
  }
}
