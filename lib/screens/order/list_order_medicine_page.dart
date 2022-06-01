import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../page_routes.dart';
import '../../widgets/cover_loading.dart';
import '../pages/emply_history_page.dart';
import 'list_order_medicine_view_model.dart';
import 'order_medicine_detail_page.dart';
class ListOrderMedicinePage extends StatefulWidget {
  const ListOrderMedicinePage({Key? key}) : super(key: key);

  @override
  _ListOrderMedicinePageState createState() => _ListOrderMedicinePageState();
}

class _ListOrderMedicinePageState extends State<ListOrderMedicinePage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();
  bool showAll = true;
  final int length = 145;

  // _showModalBottomSheet(context, detail) {
  //   showModalBottomSheet(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(15),
  //           topRight: Radius.circular(15),
  //         ),
  //       ),
  //       context: context,
  //       builder: (BuildContext ctx) {
  //         return OrderDetailPage(orderDetail: detail);
  //       }
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListOrderMedicineViewModel>();
    return Scaffold(
      appBar: PageAppBarComp(title: "Lịch sử đặt thuốc".toUpperCase()),
      body: viewModel.showEmptyLayout ? EmptyHistoryPage(
        titleButton: 'Đặt mua thuốc'.toUpperCase(),
        title: 'Bạn chưa có thông tin đơn thuốc',
        onPress: (){
          Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.orderMedicinePage);
        },
      ) : CoverLoading(
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, int index) {
                final orderMedicine = viewModel.data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderDetailPage(orderDetail: orderMedicine)));
                    //_showModalBottomSheet(context, orderMedicine);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Đơn thuốc: ', style: TextStyle(fontSize: 14, fontFamily: 'Roboto',fontWeight: FontWeight.w700,)),
                            Text(orderMedicine.categoryName ?? '', style: const TextStyle(fontSize: 14, fontFamily: 'Roboto',fontWeight: FontWeight.w400))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text('Số liệu trình:  ', style: TextStyle(fontSize: 14, fontFamily: 'Roboto',fontWeight: FontWeight.w700,)),
                            Text(orderMedicine.quantity.toString(), style: const TextStyle(fontSize: 14, fontFamily: 'Roboto',fontWeight: FontWeight.w400))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.watch_later_outlined, size: 18),
                                const SizedBox(width: 4),
                                Text('${orderMedicine.dateOrder}', style: const TextStyle(fontSize: 14, fontFamily: 'Roboto')),
                              ],
                            ),
                            Text(orderMedicine.state ?? '', style: const TextStyle(fontSize: 12)),
                          ],
                        ),
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
    );
  }
}
