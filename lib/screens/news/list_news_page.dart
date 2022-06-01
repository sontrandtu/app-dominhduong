import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/utils/extensions.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/no_result_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../page_routes.dart';
import '../../widgets/custom_cached_network_image.dart';
import '../../widgets/custom_cached_network_image_ratio.dart';
import 'list_news_view_model.dart';

class ListNewsPage extends StatefulWidget {
  const ListNewsPage({Key? key}) : super(key: key);

  @override
  _ListNewsPageState createState() => _ListNewsPageState();
}

class _ListNewsPageState extends State<ListNewsPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListNewsViewModel>();
    ArticleModel? firstItem = viewModel.data.isEmpty ? null : viewModel.data.first;
    return Scaffold(
      appBar: PageAppBarComp(
        search: true,
        favorite: true,
        isFavoriteActive: viewModel.isFavoriteActive,
        title: "Tin tức - sự kiện".toUpperCase(),
        searchCallback: (keyword) {
          var oldKeyword = viewModel.keyword;
          viewModel.keyword = keyword;
          if(viewModel.keyword != '' || (oldKeyword != '' && keyword == '')){
            viewModel.refreshData(
              needShowLoading: true,
              onLoadedCallback: () {
                _refreshController.refreshCompleted();
              },
            );
          }
        },
        favoriteCallback: (status) {
          viewModel.registerTopic(type: status ? 'add' : 'remove', successCallback: (value) {
            context.showMessage((status ? 'Theo dõi' : 'Bỏ theo dõi') + ' chuyên mục thành công!');

            setState(() {
              viewModel.isFavoriteActive = status;
            });
          }, errorCallback: (error) {
            context.showMessage((status ? 'Theo dõi' : 'Bỏ theo dõi') + ' chuyên mục thất bại!', type: MessageType.error);
          });
        },
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: CoverLoading(
                showLoading: viewModel.isLoading,
                child: SmartRefresher(
                  controller: _refreshController,
                  scrollController: scrollController,
                  enablePullUp: true,
                  onRefresh: () {
                    viewModel.refreshData(
                      needShowLoading: false,
                      onLoadedCallback: () {
                        _refreshController.refreshCompleted();
                      },
                    );
                  },
                  onLoading: () {
                    viewModel.loadMore(onLoadedCallback: () {
                      _refreshController.loadComplete();
                    });
                  },
                  child: viewModel.showEmptyLayout
                      ? const NoResultPage()
                      : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.newsDetailPage, arguments: firstItem?.id);
                          },
                          child: Container(
                            height: 330,
                            width: 382,
                            decoration: BoxDecoration(
                              color: AppColors.backgroundPage,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomNetworkImage(url: firstItem?.imageUrl ?? '', width: 382, height: 200, backgroundColor: Colors.grey.withOpacity(0.5), circular: 8, isPlaceholderImage: false),
                                const SizedBox(height: 16.0),
                                Text(
                                  firstItem?.name ?? '',
                                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: AppColors.secondaryColor, height: 1.3),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  firstItem?.description ?? '',
                                  style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: AppColors.textBlack, height: 1.3),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            final newsArticle = viewModel.data[index + 1];
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.newsDetailPage, arguments: newsArticle.id);
                                },
                                child: Container(
                                    height: 95,
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
                          itemCount: viewModel.data.isEmpty ? 0 : viewModel.data.length - 1,
                          separatorBuilder: (_, __) {
                            return const SizedBox(height: 20);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
