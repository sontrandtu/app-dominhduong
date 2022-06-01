import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/repository/article_repository.dart';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/base/loadmore_mixin.dart';

class ListContentVideoViewModel extends BaseViewModel with LoadMoreMixin<ArticleModel> {
  final ArticleRepository repo;
  final int categoryId;
  final String? categoryName;

  ListContentVideoViewModel({required this.repo,required this.categoryId, this.categoryName}) : super(repo){
    refreshData(needShowLoading: true);
  }

  @override
  Future<ApiResponse<ListResponse<List<ArticleModel>>>> getData() {
    return repo.getArticleByCategoryAndType(id: categoryId, page: pagingRequest.page!, type: 'videos');
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
