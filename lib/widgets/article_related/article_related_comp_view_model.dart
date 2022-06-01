import 'package:dominhduong/base/base_view_model.dart';
import '../../model/article_model.dart';
import '../../repository/article_repository.dart';

class ArticleRelatedCompViewModel extends BaseViewModel {
  List<ArticleModel> articleRelated = [];
  final ArticleRepository repo;
  final int id;

  ArticleRelatedCompViewModel({required this.repo, required this.id}) : super(repo) {
    getArticleRelatedData();
  }

  getArticleRelatedData() async{
    setLoading = true;
    final response = await repo.getArticleRelated(id, 1, 5);
    if (response.isOk){
      articleRelated.addAll(response.data?.items ?? []);
    }
    setLoading = false;
  }
}