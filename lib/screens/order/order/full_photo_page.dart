import 'package:cached_network_image/cached_network_image.dart';
import 'package:dominhduong/constants/app_constants.dart';
import 'package:dominhduong/constants/color_constants.dart';
import 'package:flutter/material.dart';

class FullPhotoPage extends StatelessWidget {
  final String url;

  const FullPhotoPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.fullPhotoTitle, style: TextStyle(color: ColorConstants.primaryColor)),
        centerTitle: true,
      ),
      body: InteractiveViewer(
          maxScale: 50,
          child: Container(
            alignment: Alignment.center,
            color: Colors.black,
            child: CachedNetworkImage(
              imageUrl: url,
            ),
          )),
    );
  }
}
