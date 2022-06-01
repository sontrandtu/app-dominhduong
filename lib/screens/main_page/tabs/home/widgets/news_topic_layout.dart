import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/custom_cached_network_image_ratio.dart';
import 'package:flutter/material.dart';
import 'package:dominhduong/page_routes.dart';
import 'package:shimmer/shimmer.dart';
import 'head_box.dart';

class NewsTopicLayout extends StatefulWidget {
  final List<ArticleModel> newArticles;

  const NewsTopicLayout({Key? key, required this.newArticles}) : super(key: key);

  @override
  State<NewsTopicLayout> createState() => _NewsTopicLayoutState();
}

class _NewsTopicLayoutState extends State<NewsTopicLayout> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
      child: Column(
        children: [
          const HeaderBox(title: 'Chủ đề quan tâm', viewAllTitle: 'Xem tất cả', pageRoute: PageRoutes.listLiveWellPage),
          widget.newArticles.isEmpty ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return Container(
                  height: 90,
                  padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
                  margin: const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: AppColors.textWhite,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                  ),
                );
              },
              itemCount: 4,
              separatorBuilder: (_, __) {
                return const SizedBox(width: 10);
              },
            ),
          ) : ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final newsArticle = widget.newArticles[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.liveWellDetailPage, arguments: newsArticle.id);
                  },
                  child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: AppColors.backgroundWhite,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomNetworkImageRatio(url: newsArticle.imageUrl, width: 330, height: 200, circular: 8, backgroundColor: Colors.grey.withOpacity(0.5), isPlaceholderImage: false),
                          ),
                          const SizedBox(width: 10),
                          Expanded(flex: 7, child: Text(newsArticle.name ?? '', maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, height: 1.5, color: AppColors.textBlack)))
                        ],
                      )
                  )
              );
            },
            itemCount: widget.newArticles.length,
            separatorBuilder: (_, __) {
              return const SizedBox(height: 20);
            },
          ),
        ],
      ),
    );
  }
}
