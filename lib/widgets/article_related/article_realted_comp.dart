import 'package:dominhduong/widgets/article_related/article_related_comp_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../page_routes.dart';
import '../custom_cached_network_image.dart';

class ArticleRelatedComp extends StatelessWidget{
  final String title;
  const ArticleRelatedComp({Key? key, this.title = 'Tin liên quan'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ArticleRelatedCompViewModel>();
    return viewModel.articleRelated.isNotEmpty ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.separated(
              padding: const EdgeInsets.only(left: 10, right: 10),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = viewModel.articleRelated[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.newsDetailPage, arguments: item.id);
                  },
                  child: SizedBox(
                    width: 155,
                    child: Column(
                      children: [
                        CustomNetworkImage(url: item.imageUrl, width: 155, height: 90, backgroundColor: Colors.grey.withOpacity(0.5), circular: 8, isPlaceholderImage: false),
                        SizedBox(
                          width: double.infinity,
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                                child: Text(
                                    item.name!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, height: 1.3)
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) {
                return const SizedBox(width: 10);
              },
              itemCount: viewModel.articleRelated.isEmpty ? 0: viewModel.articleRelated.length),
        ),
      ],
    ) : const SizedBox(width: 0);
  }
}
