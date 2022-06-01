import 'package:carousel_slider/carousel_slider.dart';
import 'package:dominhduong/res.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/utils/extensions/context_extension.dart';
import 'package:dominhduong/utils/extensions/text_styles_extension.dart';
import 'package:dominhduong/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../base/app_provider.dart';
import '../../../../../enum/bottom_bar_type.dart';

class SliderLayout extends StatefulWidget {
  final List<String> images;

  const SliderLayout({Key? key, required this.images}) : super(key: key);

  @override
  State<SliderLayout> createState() => _SliderLayoutState();
}

class _SliderLayoutState extends State<SliderLayout> {
  int activeIndex = 0;

  Widget buildIndicator(sliders) => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: sliders.length,
      effect: WormEffect(
          dotWidth: 0,
          dotHeight: 0,
          activeDotColor: sliders.isNotEmpty ? AppColors.secondaryColor : Colors.transparent,
          dotColor: sliders.isNotEmpty ? const Color.fromRGBO(157, 157, 158, 1) : Colors.transparent
      )
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Res.ic_dmd, height: 30,color: AppColors.secondaryColor),
                    const SizedBox(width: 10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                            "Nhà Thuốc",
                            style: context.textStyle(color: AppColors.textSecondaryColor).size12.w700.fontRobotoSlab,
                          ),
                          TextSpan(
                            text:
                            "\nĐỖ MINH ĐƯỜNG",
                            style: context.textStyle(color: AppColors.textSecondaryColor).size16.w700.fontRobotoSlab,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )
        ),
        Column(
          children: [
            const SizedBox(height: 60),
            CarouselSlider.builder(
              itemCount: widget.images.length,
              itemBuilder: (context, index, realIndex) {
                return CustomNetworkImage(url: widget.images.isEmpty ? '' : widget.images[index], width: 355, height: 160, circular: 8, isPlaceholderImage: false);
              },
              options: CarouselOptions(
                height: 160,
                initialPage: 0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 10),
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
            const SizedBox(height: 0),
            buildIndicator(widget.images),
          ],
        ),
      ],
    );
  }
}
