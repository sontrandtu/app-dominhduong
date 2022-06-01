import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/screens/traditional_medicine/list_traditional_medicine_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/custom_cached_network_image.dart';
import 'package:dominhduong/widgets/no_result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../page_routes.dart';
import '../../res.dart';

class ListTraditionalMedicinePage extends StatefulWidget {
  const ListTraditionalMedicinePage({Key? key}) : super(key: key);

  @override
  _ListTraditionalMedicinePageState createState() => _ListTraditionalMedicinePageState();
}

class _ListTraditionalMedicinePageState extends State<ListTraditionalMedicinePage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListTraditionalMedicineViewModel>();
    ArticleModel? firstItem = viewModel.data.isEmpty ? null : viewModel.data.first;
    return Scaffold(
      appBar: PageAppBarComp(title: "Bài thuốc gia truyền".toUpperCase(), canPop: true),
      backgroundColor: const Color(0xFFFAFAFA),
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
                child: viewModel.showEmptyLayout ? const NoResultPage() : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                        child: Stack(
                          children: [
                            ClipRRect(child: Image.asset(Res.image_medicine_details, width: 382, height: 144), borderRadius: BorderRadius.circular(8.0)),
                            const Positioned(
                              top: 33,
                              left: 17.12,
                              right: 17.12,
                              bottom: 33,
                              child: Text(
                                "Là nhà thuốc gia truyền 5 đời, trải dài theo chiều dài 3 thế kỷ, Đỗ Minh Đường tự hào đã nghiên cứu, ứng dụng thành công nhiều bài thuốc gia truyền hiệu nghiệm, kết tinh từ 100% Nam dược đất Việt",
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.0, height: 1.3),
                                maxLines: 5,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.traditionalMedicineDetailPage, arguments: firstItem?.id);
                        },
                        child: Container(
                          width: 382,
                          height: 280,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundWhite,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              CustomNetworkImage(url: firstItem?.imageUrl ?? '', width: 382, height: 200, circular: 8.0, backgroundColor: Colors.grey.withOpacity(0.5), isPlaceholderImage: false),
                              const SizedBox(height: 16.0),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 15, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16.13),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            firstItem?.name?.toUpperCase() ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.secondaryColor, height: 1.5),
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(firstItem?.rating != 0 ? Res.ic_star : Res.ic_star_outline, width: 20, color: AppColors.primaryColor),
                                              const SizedBox(width: 8),
                                              Text(
                                                firstItem?.rating.toString() ?? '',
                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        controller: scrollController,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16.54,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final medicine = viewModel.data[index + 1];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.traditionalMedicineDetailPage, arguments: medicine.id);
                            },
                            child: Container(
                              height: 130,
                              width: 180,
                              decoration: BoxDecoration(color: AppColors.backgroundWhite,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                children: [
                                  CustomNetworkImage(url: medicine.imageUrl, width: 183, height: 96, circular: 8.0, backgroundColor: Colors.grey.withOpacity(0.5), isPlaceholderImage: false),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(left: 12, right: 10, top: 12),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          medicine.name ?? '',
                                          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: AppColors.secondaryColor, height: 1.2),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: viewModel.data.isEmpty ? 0 : viewModel.data.length - 1,
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
