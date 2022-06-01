import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/repository/article_repository.dart';

class VideoDetailViewModel extends BaseViewModel {
  final ArticleRepository repo;
  final ArticleModel articleModel;
  String? content;
  final String? categoryName;

  VideoDetailViewModel({required this.repo, required this.articleModel, this.categoryName}) : super(repo){
    getArticleDetailData();
  }


  getArticleDetailData() async {
    setLoading = true;
    final response = await repo.getArticleDetail(articleModel.id!);
    if (response.isOk) {
      content = response.data?.content;
    }
    setLoading = false;
  }
}
