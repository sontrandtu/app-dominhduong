import 'package:dominhduong/screens/history/history_detail_page.dart';
import 'package:dominhduong/screens/history/list_history_view_model.dart';
import 'package:dominhduong/screens/pages/emply_history_page.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../../page_routes.dart';

class ListHistoryPage extends StatefulWidget {
  final bool? isReloadHistory;
  final bool? isMain;
  final bool canPop;
  const ListHistoryPage({Key? key, this.isReloadHistory = false, this.isMain = false, this.canPop = true}) : super(key: key);

  @override
  State<ListHistoryPage> createState() => _ListHistoryPageState();
}

class _ListHistoryPageState extends State<ListHistoryPage> with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = context.watch<ListHistoryViewModel>();
    return Scaffold(
      appBar: PageAppBarComp(title: 'Lịch sử đặt lịch'.toUpperCase(), canPop: widget.canPop),
      backgroundColor: const Color(0xFFF6F6F6),
      body: Stack(
        children: [
          CoverLoading(
            showLoading: viewModel.isLoading,
            child: viewModel.showEmptyLayout ? EmptyHistoryPage(
              titleButton: 'Đặt lịch'.toUpperCase(),
              title: 'Bạn chưa có lịch sử đặt lịch khám - trị liệu',
              onPress: (){
                Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.treatment, arguments: 0).then((value) => viewModel.refreshData());
              },
            ) : SmartRefresher(
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
              child: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.data.length,
                    padding: widget.isMain == null ? const EdgeInsets.symmetric(horizontal: 10, vertical: 15) : const EdgeInsets.only(bottom: 30),
                    itemBuilder: (BuildContext context, int index) {
                      final history = viewModel.data[index];
                      return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              useRootNavigator: true,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                                context: context,
                                builder: (BuildContext ctx) {
                                  return HistoryDetailPage(historyModel: viewModel.data[index]);
                                }
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(history.name!, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xff3b2313), fontFamily: 'Roboto'),overflow: TextOverflow.ellipsis,),
                                const SizedBox(height: 10),
                                LineCard(title: 'Vào lúc: ', content: history.timeSlotName ?? ''),
                                LineCard(title: 'Ngày: ', content: history.dateStart ?? ''),
                                const SizedBox(height: 10),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     const Icon(Icons.watch_later_outlined, size: 15),
                                //     const SizedBox(width: 5),
                                //     Text('${history.timeSlotName!} - ${history.dateStart!}', style: const TextStyle(fontSize: 14, fontFamily: 'Roboto')),
                                //   ],
                                // )
                              ],
                            ),
                          )
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const SizedBox(height: 15);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LineCard extends StatelessWidget {
  final String? title;
  final String? content;
  const LineCard({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: RichText(
        text: TextSpan(
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
            ),
            children: [
              TextSpan(
                  text: title!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 14)),
              TextSpan(
                  text: content!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                      fontSize: 14))
            ]),
      ),
    );
  }
}

