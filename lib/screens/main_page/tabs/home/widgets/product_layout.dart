import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/page_routes.dart';
import 'package:dominhduong/screens/main_page/tabs/home/widgets/head_box.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../res.dart';

class ProductLayout extends StatefulWidget {
  final List<ArticleModel> products;

  const ProductLayout({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductLayout> createState() => _ProductLayoutState();
}

class _ProductLayoutState extends State<ProductLayout> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          const HeaderBox(title: 'Đỗ Minh Gia Quý', viewAllTitle: 'Xem tất cả', pageRoute: PageRoutes.listProductPage),
          SizedBox(
            height: 210,
            child: widget.products.isEmpty ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.separated(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Container(
                      width: 160,
                      padding: const EdgeInsets.only(top: 25, bottom: 20, left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: AppColors.textWhite,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(width: 10);
                  },
                  itemCount: 5),
            )
                : ListView.separated(
                padding: const EdgeInsets.only(left: 10, right: 10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final product = widget.products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.productDetailPage, arguments: product.id);
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomNetworkImage(url: product.imageUrl, width: 180, height: 112, backgroundColor: Colors.grey.withOpacity(0.5), circular: 8, borderStyle: 'top', isPlaceholderImage: false),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    product.name!.toUpperCase(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, height: 1.3, color: AppColors.secondaryColor)
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(product.rating != 0 ? Res.ic_star : Res.ic_star_outline, height: 24),
                                        const SizedBox(width: 5),
                                        Text(
                                            product.rating.toString(),
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textBlack)
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(width: 10);
                },
                itemCount: widget.products.length
            ),
          )
        ],
      ),
    );
  }
}
