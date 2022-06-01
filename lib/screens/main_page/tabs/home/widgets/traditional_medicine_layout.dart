import 'package:dominhduong/screens/main_page/tabs/home/widgets/head_box.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../model/article_model.dart';
import '../../../../../page_routes.dart';
import '../../../../../widgets/custom_cached_network_image.dart';

class TraditionalMedicineLayout extends StatefulWidget {
  final List<ArticleModel> medicines;

  const TraditionalMedicineLayout({Key? key, required this.medicines}) : super(key: key);

  @override
  State<TraditionalMedicineLayout> createState() => _TraditionalMedicineLayoutState();
}

class _TraditionalMedicineLayoutState extends State<TraditionalMedicineLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        const HeaderBox(title: "Bài thuốc gia truyền", viewAllTitle: "Xem tất cả", pageRoute: PageRoutes.traditionalMedicinePage),
        SizedBox(
          height: 175.5,
          child: widget.medicines.isEmpty ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
              //physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return Container(
                  width: 300,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.textWhite,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
              itemCount: 5,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 15);
              },
            ),
          ) : ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
              itemBuilder: (_, index) {
                final medicines = widget.medicines[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.traditionalMedicineDetailPage, arguments: medicines.id);
                  },
                  child: Container(
                    width: 300,
                    height: 175.5,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundPage,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomNetworkImage(url: medicines.imageUrl, width: 336, height: 175.5, circular: 8, isPlaceholderImage: false, backgroundColor: Colors.grey.withOpacity(0.5)),
                  ),
                );
              },
              separatorBuilder: (_, __)  => const SizedBox(width: 15),
              itemCount: widget.medicines.length
          ),
        )
      ],
    );
  }
}
