import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/base/loadmore_mixin.dart';
import 'package:dominhduong/model/examination_card_model.dart';
import 'package:dominhduong/repository/examination_card_repository.dart';

class ListExaminationCardViewModel extends BaseViewModel with LoadMoreMixin<ExaminationCardModel> {
  final ExaminationCardRepository repo;

  ListExaminationCardViewModel(this.repo) : super(repo){
    refreshData(needShowLoading: true);
  }

  @override
  Future<ApiResponse<ListResponse<List<ExaminationCardModel>>>> getData() {
    return repo.getListExaminationCard(pagingRequest.page!);
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
