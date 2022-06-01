import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/custom_cached_network_image_ratio.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dominhduong/utils/extensions.dart';

class ArtistLayout extends StatefulWidget {
  final List<ArticleModel> articles;

  const ArtistLayout({Key? key, required this.articles}) : super(key: key);

  @override
  State<ArtistLayout> createState() => _ArtistLayoutState();
}

class _ArtistLayoutState extends State<ArtistLayout> {
  int activeIndex = 0;

  Widget _buildIndicator(items) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: items.length,
      effect: JumpingDotEffect(
        dotWidth: 6,
        dotHeight: 6,
        activeDotColor: items.isNotEmpty ? AppColors.secondaryColor : Colors.transparent,
        dotColor: items.isNotEmpty ? const Color.fromRGBO(157, 157, 158, 1) : Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.articles.isEmpty
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 510,
                    padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: AppColors.textWhite,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                    ),
                  ))
              : CarouselSlider.builder(
                  itemCount: widget.articles.length,
                  itemBuilder: (context, index, realIndex) {
                    return Column(
                      children: [
                        CustomNetworkImageRatio(url: widget.articles.isEmpty ? '' : widget.articles[index].imageUrl, width: 235, height: 185, backgroundColor: Colors.grey.withOpacity(0.5), isPlaceholderImage: false),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.articles.isEmpty ? '' : widget.articles[index].name!.toUpperCase(),
                              style: TextStyle(color: AppColors.primaryColor, fontSize: 14, fontFamily: 'RobotoSlab', fontWeight: FontWeight.w700, height: 1.3),
                            ),
                            const SizedBox(width: 6),
                            Text(r'"', style: TextStyle(fontSize: 55, fontFamily: 'Conestoga', color: AppColors.primaryColor)),
                          ],
                        ),
                        Text(
                          widget.articles.isEmpty ? '' : widget.articles[index].description!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 6,
                          textAlign: TextAlign.justify,
                          style: context.textStyle().textHeight(1.5).size14,
                        )
                      ],
                    );
                  },
                  options: CarouselOptions(
                    initialPage: 0,
                    autoPlay: true,
                    height: 510,
                    autoPlayInterval: const Duration(seconds: 15),
                    autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),
          const SizedBox(height: 5),
          _buildIndicator(widget.articles),
        ],
      ),
    );
  }
}
