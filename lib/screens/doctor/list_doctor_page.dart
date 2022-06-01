import 'package:dominhduong/model/doctor_model.dart';
import 'package:dominhduong/page_routes.dart';
import 'package:dominhduong/screens/doctor/list_doctor_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/utils/extensions.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/custom_cached_network_image.dart';
import 'package:dominhduong/widgets/no_result_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../res.dart';

class ListDoctorPage extends StatefulWidget {
  const ListDoctorPage({Key? key}) : super(key: key);

  @override
  _ListDoctorPageState createState() => _ListDoctorPageState();
}

class _ListDoctorPageState extends State<ListDoctorPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListDoctorViewModel>();
    DoctorModel? firstItem = viewModel.data.isEmpty ? null : viewModel.data.first;
    return Scaffold(
        appBar: PageAppBarComp(title: 'BÁC SĨ'),
        backgroundColor: const Color(0xffffffff),
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
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Column(
                          children: [
                            viewModel.isLoading ? const SizedBox() : Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(top: 64),
                                    padding: const EdgeInsets.only(left: 15, top: 80, right: 15, bottom: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                            firstItem?.name?.toUpperCase() ?? '',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'RobotoSlab', color: AppColors.primaryColor)
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                            firstItem?.position ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.secondaryColor)
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     showMessage("Chức năng đang được phát triển");
                                              //   },
                                              //   child: Container(
                                              //     width: 100,
                                              //     height: 36,
                                              //     decoration: BoxDecoration(
                                              //         color: AppColors.secondaryColor,
                                              //         borderRadius: BorderRadius.circular(8)
                                              //     ),
                                              //     child: Row(
                                              //       mainAxisAlignment: MainAxisAlignment.center,
                                              //       crossAxisAlignment: CrossAxisAlignment.center,
                                              //       children: [
                                              //         SvgPicture.asset(Res.ic_video_call),
                                              //         const SizedBox(width: 5),
                                              //         const Text(
                                              //             'Video call',
                                              //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textWhite)
                                              //         )
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: [firstItem?.branchId, firstItem?.physicianId]);
                                                },
                                                child: Container(
                                                  width: 150,
                                                  height: 36,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.secondaryColor,
                                                      borderRadius: BorderRadius.circular(8)
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Image.asset(Res.ic_calendar_dc, width: 28.36, height: 24,),
                                                      const SizedBox(width: 5),
                                                      const Text(
                                                          'Đặt lịch',
                                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textWhite)
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(context, PageRoutes.doctorDetailPage, arguments: firstItem!.id);
                                                },
                                                child: Container(
                                                  width: 150,
                                                  height: 36,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.secondaryColor,
                                                      borderRadius: BorderRadius.circular(8)
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: const [
                                                      Text(
                                                          'Xem hồ sơ',
                                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textWhite)
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ]
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          firstItem?.description ?? '',
                                          style: const TextStyle(color: Colors.black, fontFamily: 'Roboto', fontSize: 14, height: 1.4),
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff3B2313).withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(8),
                                    )
                                ),
                                SizedBox(
                                  width: 128,
                                  height: 128,
                                  child: CustomNetworkImage(url: firstItem?.imageUrl ?? '', width: 128, height: 128, backgroundColor: Colors.grey.withOpacity(0.5), isCircle: true, isPlaceholderImage: false),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            GridView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                              shrinkWrap: true,
                              controller: scrollController,
                              itemCount: viewModel.data.isEmpty ? 0 : viewModel.data.length - 1,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 160 / 200,
                              ),
                              itemBuilder: (_, int index) {
                                final doctor = viewModel.data[index + 1];
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.pushNamed(context, PageRoutes.doctorDetailPage, arguments: doctor.id);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                                    decoration: BoxDecoration(
                                      // color: Colors.red,
                                        color: const Color(0xffFAFAFA),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Column(
                                      children: [
                                        CustomNetworkImage(url: doctor.imageUrl, width: 70, height: 70, backgroundColor: Colors.grey.withOpacity(0.5), isCircle: true, isPlaceholderImage: false, circular: 8.0,),
                                        const SizedBox(height: 15),
                                        Text(
                                          doctor.splitName?.toUpperCase() ?? '',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.textStyle(color: AppColors.textBlack).size12.w700.fontRobotoSlab,
                                        ),
                                        const SizedBox(height: 15),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: [doctor.branchId, doctor.physicianId]);
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 36,
                                            decoration: BoxDecoration(
                                                color: AppColors.secondaryColor,
                                                borderRadius: BorderRadius.circular(8)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(Res.ic_calendar_dc, width: 28.36, height: 24,),
                                                const SizedBox(width: 5),
                                                const Text(
                                                    'Đặt lịch',
                                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textWhite)
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
