import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/no_result_page.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'list_order_view_model.dart';
import 'order_detail_page.dart';
import 'package:provider/provider.dart';

class ListOrderPage extends StatefulWidget {
  final int detailId;
  const ListOrderPage({Key? key, this.detailId = 0}) : super(key: key);

  @override
  _ListOrderPageState createState() => _ListOrderPageState();
}

class _ListOrderPageState extends State<ListOrderPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  _showModalBottomSheet(context, detail) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (BuildContext ctx) {
          return OrderDetailPage(orderDetail: detail);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListOrderViewModel>();

    Future.delayed(const Duration(seconds: 0)).then((_) {
      if(widget.detailId > 0) {
        final idx = viewModel.data.indexWhere((el) => el.id == widget.detailId);
        if (idx >= 0) {
          _showModalBottomSheet(context, viewModel.data[idx]);
        }
      }
    });

    return Scaffold(
      appBar: PageAppBarComp(title: 'Thông tin đơn hàng'.toUpperCase()),
      backgroundColor: const Color(0xffeeeeee),
      body: CoverLoading(
        showLoading: viewModel.isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            child: viewModel.showEmptyLayout ? const NoResultPage() : ListView.separated(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              itemBuilder: (_, int index) {
                final order = viewModel.data[index];
                return GestureDetector(
                  onTap: () {
                    if (order.orderLines!.isNotEmpty) _showModalBottomSheet(context, order);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Mã đơn hàng: ${order.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const Spacer(),
                            Text('${order.productNumber} Sản phẩm', style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.watch_later_outlined, size: 18),
                            const SizedBox(width: 4),
                            Text('${order.dateOrder}', style: const TextStyle(fontSize: 14, fontFamily: 'Roboto')),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.attach_money_outlined, size: 18),
                            const SizedBox(width: 5),
                            Text('Tổng tiền: ${order.amountTotal}đ', style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: viewModel.data.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 10);
              },
            ),
          ),
        ),
      ),
    );
  }
}
