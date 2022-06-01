import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../app_config.dart';
import '../../../../../page_routes.dart';
import '../../../../../widgets/custom_cached_network_image.dart';
import 'head_box.dart';

class ServicesCategoryLayout extends StatefulWidget {
  final List<ArticleModel> articles;

  const ServicesCategoryLayout({Key? key, required this.articles})
      : super(key: key);

  @override
  State<ServicesCategoryLayout> createState() => _ServicesCategoryLayoutState();
}

class _ServicesCategoryLayoutState extends State<ServicesCategoryLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeaderBox(
            title: 'Dịch vụ',
            viewAllTitle: 'Xem tất cả',
            pageRoute: PageRoutes.servicePage,
            arguments: AppConfig.diseaseCategoryId),
        Padding(
          padding:
              const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
          child: widget.articles.isEmpty
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return Container(
                        height: 90,
                        width: 180,
                        decoration: BoxDecoration(
                          color: AppColors.textWhite,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1, color: Colors.grey.withOpacity(0.2)),
                        ),
                      );
                    },
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 180 / 160,
                    ),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.articles.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 180 / 160,
                  ),
                  itemBuilder: (context, int index) {
                    final medicine = widget.articles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                            PageRoutes.serviceDetailPage,
                            arguments: medicine.id);
                      },
                      child: Container(
                        height: 144,
                        width: 183,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomNetworkImage(
                                url: medicine.imageUrl,
                                width: 183,
                                height: 93.02,
                                backgroundColor: Colors.grey.withOpacity(0.5),
                                circular: 8,
                                borderStyle: 'top',
                                isPlaceholderImage: false),
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(medicine.name!,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
