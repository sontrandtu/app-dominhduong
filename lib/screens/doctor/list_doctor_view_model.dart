import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/base/loadmore_mixin.dart';
import 'package:dominhduong/model/doctor_model.dart';
import 'package:dominhduong/repository/doctor_repository.dart';

class ListDoctorViewModel extends BaseViewModel with LoadMoreMixin<DoctorModel> {
  final DoctorRepository repo;

  ListDoctorViewModel(this.repo) : super(repo){
    refreshData(needShowLoading: true);
  }

  @override
  Future<ApiResponse<ListResponse<List<DoctorModel>>>> getData() {
    return repo.getListDoctor(pagingRequest.page!);
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
