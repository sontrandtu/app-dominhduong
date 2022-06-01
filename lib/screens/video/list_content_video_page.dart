import 'package:dominhduong/page_routes.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/custom_cached_network_image_ratio.dart';
import 'package:dominhduong/widgets/no_result_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'list_content_video_view_model.dart';

class ListContentVideoPage extends StatefulWidget{
  const ListContentVideoPage({Key? key}) : super(key: key);

  @override
  State<ListContentVideoPage> createState() => _ListContentVideoPageState();
}

class _ListContentVideoPageState extends State<ListContentVideoPage> with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  final ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = context.watch<ListContentVideoViewModel>();
    return Scaffold(
      body: CoverLoading(
        color: Colors.white,
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
          child: viewModel.showEmptyLayout ? const NoResultPage() : SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 30),
                itemBuilder: (BuildContext context, int index) {
                  final article = viewModel.data[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.videoDetailPage, arguments: [article, viewModel.categoryName]);
                      },
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomNetworkImageRatio(url: article.imageUrl, width: 330, height: 200, circular: 12, backgroundColor: Colors.grey.withOpacity(0.5), isPlaceholderImage: false),
                              const Icon(Icons.play_circle_outline, size: 40, color: Colors.white),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(article.name ?? '', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, height: 1.5))
                        ],
                      )
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 30);
                },
                itemCount: viewModel.data.isEmpty ? 0 : viewModel.data.length,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
