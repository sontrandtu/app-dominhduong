import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/repository/article_repository.dart';

class TraditionalMedicineDetailViewModel extends BaseViewModel{
  final ArticleRepository repo;
  final int articleId;

  ArticleModel? article;

  String? userName;
  String? numberPhone;
  String? email;
  String reason = '';

  TraditionalMedicineDetailViewModel({this.article, required this.repo, required this.articleId}) : super(repo) {
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