import 'package:dominhduong/screens/product/list_product_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/no_result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dominhduong/page_routes.dart';

import '../../res.dart';
import '../../widgets/custom_cached_network_image.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({Key? key}) : super(key: key);

  @override
  _ListProductPageState createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListProductViewModel>();
    return Scaffold(
      appBar: PageAppBarComp(title: 'Đỗ minh gia quý'.toUpperCase()),
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            CoverLoading(
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
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      viewModel.isLoading ? const SizedBox() : Container(
                        margin: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(child: Image.asset(Res.image_medicine_details), borderRadius: BorderRadius.circular(8.0)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Đỗ Minh Gia Quý",
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.primaryColor, fontFamily: 'RobotoSlab'),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 7),
                                  const Text(
                                    "Tuyển tập những bài thuốc siêu quý hiếm nằm trong Đỗ Minh bí tịch, giúp kiện toàn sức khỏe, tăng cường và cải thiện sinh lý nam, nữ, gia tăng tuổi thọ, tăng sức đề kháng cho cơ thể",
                                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.textBlack, height: 1.3),
                                    maxLines: 4,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: viewModel.data.isEmpty ? 0 : viewModel.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final article = viewModel.data[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.productDetailPage, arguments: article.id);
                              },
                              child:
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomNetworkImage(url: article.imageUrl, width: 382, height: 238, backgroundColor: Colors.grey.withOpacity(0.5), circular: 8, borderStyle: 'top', isPlaceholderImage: false),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              article.name!.toUpperCase(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primaryColor, fontFamily: 'RobotoSlab')
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                              article.description!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.3, color: AppColors.textBlack)
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                              '* Số lượng có hạn - hàng đặt trước',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.primaryColor)
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(article.rating != 0 ? Res.ic_star : Res.ic_star_outline, height: 26),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      article.rating!.toString(),
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
                            return const SizedBox(height: 20);
                          },
                        ),
                      ),
                    ],
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