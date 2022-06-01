 import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/repository/article_repository.dart';

class NewsDetailViewModel extends BaseViewModel {
  final ArticleRepository repo;
  final int articleId;

  ArticleModel? article;

  NewsDetailViewModel({required this.repo, required this.articleId}) : super(repo) {
    getArticleDetailData();
  }

  getArticleDetailData() async {
    setLoading = true;
    final response = await repo.getArticleDetail(articleId);
    if (response.isOk) {
      article = response.data;
    }
    setLoading = false;
  }
}
