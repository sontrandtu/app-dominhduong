import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/base/loadmore_mixin.dart';
import 'package:dominhduong/model/order_medicine_model.dart';
import 'package:dominhduong/repository/order_repository.dart';

class ListOrderMedicineViewModel extends BaseViewModel with LoadMoreMixin<OrderMedicineModel>{
  final OrderRepository repo;
  List<OrderMedicineModel> listOrderMedicine = [];

  ListOrderMedicineViewModel({required this.repo}):super(repo){
    refreshData(needShowLoading: true);
  }

  @override
  Future<ApiResponse<ListResponse<List<OrderMedicineModel>>>> getData() {
    return repo.getListOrderMedicine(pagingRequest.page!);
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