import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/base/loadmore_mixin.dart';
import 'package:dominhduong/model/order_model.dart';
import 'package:dominhduong/repository/order_repository.dart';

class ListOrderViewModel extends BaseViewModel with LoadMoreMixin<OrderModel> {
  final OrderRepository repo;
  final int? id;

  ListOrderViewModel(this.repo, {this.id}) : super(repo) {
    refreshData(needShowLoading: true);
  }

  @override
  Future<ApiResponse<ListResponse<List<OrderModel>>>> getData() {
    return repo.getListOder(id, pagingRequest.page!);
  }

  @override
  void notifyData() {
    notifyListeners();
  }

  @override
  set notifyLoading(bool value) {
    setLoading = value;
  }
}
