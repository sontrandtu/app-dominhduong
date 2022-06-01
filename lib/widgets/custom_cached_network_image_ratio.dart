import 'package:cached_network_image/cached_network_image.dart';
import 'package:dominhduong/res.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomNetworkImageRatio extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final double circular;
  final bool isPlaceholderImage;
  final bool isCircle;
  final Color backgroundColor;
  final double borderWidth;
  final Color borderColor;

  const CustomNetworkImageRatio({Key? key, required this.url, required this.width, required this.height, this.circular = 15, this.isPlaceholderImage = true, this.isCircle = false, this.backgroundColor = AppColors.secondaryColor, this.borderWidth = 0, this.borderColor = AppColors.textPrimaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        placeholder: (_, __) {
          return AspectRatio(
            aspectRatio: width/height,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                border: borderWidth != 0 ? Border.all(width: borderWidth, color: borderColor) : null,
                borderRadius: isCircle ? null : BorderRadius.circular(circular),
                image: isPlaceholderImage ? const DecorationImage(
                  image: AssetImage(Res.placeholder),
                  fit: BoxFit.cover,
                ) : null,
              ),
            ),
          );
        },
        errorWidget: (_, __, ___) => AspectRatio(
          aspectRatio: width/height,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              border: borderWidth != 0 ? Border.all(width: borderWidth, color: borderColor) : null,
              borderRadius: isCircle ? null : BorderRadius.circular(circular),
              image: isPlaceholderImage ? const DecorationImage(
                image: AssetImage(Res.placeholder),
                fit: BoxFit.cover,
              ) : null,
            ),
          ),
        ),
        imageBuilder: (context, imageProvider) => AspectRatio(
          aspectRatio: width/height,
          child: Container(
            decoration: BoxDecoration(
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              border: borderWidth != 0 ? Border.all(width: borderWidth, color: borderColor) : null,
              borderRadius: isCircle ? null : BorderRadius.circular(circular),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
    );
  }
}
