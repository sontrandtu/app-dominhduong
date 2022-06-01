import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/repository/article_repository.dart';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/base/loadmore_mixin.dart';
import 'package:dominhduong/enum/slug.dart';

class ListProductViewModel extends BaseViewModel with LoadMoreMixin<ArticleModel> {
  final ArticleRepository repo;

  ListProductViewModel(this.repo) : super(repo){
    refreshData(needShowLoading: true);
  }

  @override
  Future<ApiResponse<ListResponse<List<ArticleModel>>>> getData() {
    return repo.getArticleByType(slug: Slug.productPage, page: pagingRequest.page!);
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
