import 'package:dominhduong/page_routes.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../model/article_model.dart';
import '../../../../../widgets/custom_cached_network_image.dart';
import 'head_box.dart';

class NewsLayout extends StatefulWidget {
  final List<ArticleModel> newArticles;
  final int newsId;

  const NewsLayout({Key? key, required this.newArticles, required this.newsId}) : super(key: key);

  @override
  State<NewsLayout> createState() => _NewsLayoutState();
}

class _NewsLayoutState extends State<NewsLayout> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      child: Column(
        children: [
          HeaderBox(title: 'Tin tức - Sự kiện', viewAllTitle: 'Xem tất cả', pageRoute: PageRoutes.newsPage, arguments: widget.newsId),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
            child: widget.newArticles.isEmpty
                ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return Container(
                    height: 120,
                    width: 180,
                    decoration: BoxDecoration(
                      color: AppColors.textWhite,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                    ),
                  );
                },
                itemCount: 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 180 / 180,
                ),
              ),
            )
                : GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.newArticles.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 16,
                childAspectRatio: 180 / 180,
              ),
              itemBuilder: (context, int index) {
                final news = widget.newArticles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.newsDetailPage, arguments: news.id);
                  },
                  child: Container(
                    height: 170,
                    width: 183,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomNetworkImage(url: news.imageUrl, width: 183, height: 102.94, backgroundColor: Colors.grey.withOpacity(0.5), circular: 8, borderStyle: 'top', isPlaceholderImage: false),
                        SizedBox(
                          width: double.infinity,
                          height: 65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                    news.name!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.3)
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}