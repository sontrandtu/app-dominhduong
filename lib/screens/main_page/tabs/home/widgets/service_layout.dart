import 'package:dominhduong/model/category_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dominhduong/utils/extensions.dart';
import 'package:dominhduong/page_routes.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../app_config.dart';
import 'head_box.dart';

class ServiceLayout extends StatefulWidget {
  final List<CategoryModel> categories;

  const ServiceLayout({Key? key, required this.categories}) : super(key: key);

  @override
  State<ServiceLayout> createState() => _ServiceLayoutState();
}

class _ServiceLayoutState extends State<ServiceLayout> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        children: [
          const HeaderBox(title: 'Dịch vụ v1', viewAllTitle: 'Xem tất cả', pageRoute: PageRoutes.servicePage, arguments: AppConfig.diseaseCategoryId),
          SizedBox(
            height: 150,
            child: widget.categories.isEmpty
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListView.separated(
                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Container(
                            width: 150,
                            padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: AppColors.textWhite,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) {
                          return const SizedBox(width: 20);
                        },
                        itemCount: 5),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final category = widget.categories[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.servicePage, arguments: category.id);
                        },
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: AppColors.textWhite,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                          ),
                          child: Column(
                            children: [
                              CustomNetworkImage(url: category.imageUrl, width: 50, height: 50, backgroundColor: Colors.grey.withOpacity(0.5), isCircle: true, isPlaceholderImage: true),
                              const SizedBox(height: 10),
                              Text(
                                category.name.toString(),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.textStyle(color: AppColors.textSecondaryColor).size14.fontRobotoSlab,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const SizedBox(width: 20);
                    },
                    itemCount: widget.categories.length),
          )
        ],
      ),
    );
  }
}
