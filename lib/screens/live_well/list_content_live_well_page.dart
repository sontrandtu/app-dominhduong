import 'package:dominhduong/screens/live_well/list_content_live_well_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../page_routes.dart';
import '../../theme/colors.dart';
import '../../widgets/cover_loading.dart';
import '../../widgets/custom_cached_network_image_ratio.dart';
import '../../widgets/no_result_page.dart';

class ListContentLiveWellPage extends StatefulWidget {
  const ListContentLiveWellPage({Key? key}) : super(key: key);

  @override
  _ListContentLiveWellPageState createState() => _ListContentLiveWellPageState();
}

class _ListContentLiveWellPageState extends State<ListContentLiveWellPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListContentLiveWellViewModel>();
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
          child: viewModel.showEmptyLayout ? const NoResultPage() : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final article = viewModel.data[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PageRoutes.liveWellDetailPage, arguments: article.id);
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
                              child: CustomNetworkImageRatio(url: article.imageUrl, width: 330, height: 200, circular: 8, backgroundColor: Colors.grey.withOpacity(0.5), isPlaceholderImage: false),
                            ),
                            const SizedBox(width: 10),
                            Expanded(flex: 7, child: Text(article.name!, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, height: 1.5, color: AppColors.textBlack)))
                          ],
                        )
                    )
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 20);
              },
              itemCount: viewModel.data.isEmpty ? 0 : viewModel.data.length,
            ),
          ),
        ),
      ),
    );
  }
}
