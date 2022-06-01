import 'package:dominhduong/screens/examination_card/list_examination_card_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/no_result_page.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import '../../page_routes.dart';
import 'examination_card_detail.dart';

class ListExaminationCardPage extends StatefulWidget {
  final int detailId;
  const ListExaminationCardPage({Key? key, this.detailId = 0}) : super(key: key);

  @override
  _ListExaminationCardState createState() => _ListExaminationCardState();
}

class _ListExaminationCardState extends State<ListExaminationCardPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  _showModalBottomSheet(context, examinationCard) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (BuildContext ctx) {
          return ExaminationCardDetailPage(examinationCardDetail: examinationCard);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListExaminationCardViewModel>();

    Future.delayed(const Duration(seconds: 0)).then((_) {
      if(widget.detailId > 0) {
        final idx = viewModel.data.indexWhere((el) => el.id == widget.detailId);
        if (idx >= 0) {
          _showModalBottomSheet(context, viewModel.data[idx]);
        }
      }
    });

    return Scaffold(
      appBar: PageAppBarComp(title: 'Thông tin phiếu khám'.toUpperCase()),
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
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
            child: viewModel.showEmptyLayout ? const NoResultPage() : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              child: ListView.separated(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, int index) {
                  final examinationCard = viewModel.data[index];
                  return GestureDetector(
                    onTap: () {
                      _showModalBottomSheet(context, examinationCard);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Mã phiếu khám: ${examinationCard.name}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xff3b2313))),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [const Icon(Icons.watch_later_outlined, size: 15),
                                      const SizedBox(width: 4),
                                      Text(examinationCard.dateStart??'', style: const TextStyle(fontSize: 14, fontFamily: 'Roboto'),)],
                                  ),
                                  const SizedBox(height: 5),
                                  if(examinationCard.physicianName != null) Row(
                                    children: [
                                      const Icon(Icons.account_circle_outlined, size: 15),
                                      const SizedBox(width: 5),
                                      Text(examinationCard.physicianName ?? '', style: const TextStyle(fontSize: 14)),
                                      const SizedBox(width: 6),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 60,
                                height: 25,
                                child: examinationCard.orderCount! > 0 ? ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.listOrderPage, arguments: [examinationCard.id, 0]);
                                    },
                                    style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, elevation: 0),
                                    child: const Text('Đơn hàng', style: TextStyle(color: AppColors.textWhite, fontSize: 12))
                                ) : null,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: viewModel.data.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 20);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

