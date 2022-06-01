import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/model/branch_model.dart';
import 'package:dominhduong/repository/hotline_repository.dart';

class HotlineViewModel extends BaseViewModel {
  List<BranchModel> branches = [];

  final HotlineRepository callCenterRepository;

  HotlineViewModel(this.callCenterRepository) : super(callCenterRepository) {
    loadBranchData();
  }

  loadBranchData() async {
    setLoading = true;
    final response = await callCenterRepository.getBranches();
    if (response.isOk) {
      branches.addAll(response.data?.items ?? []);
    }
    notifyListeners();
    setLoading = false;
  }
}