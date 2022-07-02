import 'list_service_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/no_result_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../page_routes.dart';
import '../../widgets/custom_cached_network_image.dart';

class ListServicePage extends StatefulWidget {
  const ListServicePage({Key? key}) : super(key: key);

  @override
  _ListServicePageState createState() => _ListServicePageState();
}

class _ListServicePageState extends State<ListServicePage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListServiceViewModel>();
    return Scaffold(
      appBar: PageAppBarComp(title: "Dịch vụ".toUpperCase()),
      backgroundColor: Color(0xFFEFECEC),
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
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final medicine = viewModel.data[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.serviceDetailPage, arguments: medicine.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  CustomNetworkImage(url: medicine.imageUrl, width: 382, height: 194, backgroundColor: Colors.grey.withOpacity(0.5), circular: 8, isPlaceholderImage: false),
                                  Column(
                                    children: [
                                      const SizedBox(height: 15),
                                      Text(
                                        medicine.name!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, height: 1.5),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        medicine.description!,
                                        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, height: 1.4),
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 42,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: 0);
                                          },
                                          child: const Text(
                                              'ĐẶT LỊCH',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textWhite)
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.secondaryColor),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                  // side: BorderSide(color: Colors.red)
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 25);
                    },
                    itemCount: viewModel.data.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //floatingActionButton: const CustomFloatingButton(),
    );
  }
}
