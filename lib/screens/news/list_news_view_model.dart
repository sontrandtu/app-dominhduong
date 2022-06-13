import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/base/loadmore_mixin.dart';
import 'package:dominhduong/enum/slug.dart';
import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/repository/article_repository.dart';
import 'package:dominhduong/repository/user_repository.dart';


class ListNewsViewModel extends BaseViewModel with LoadMoreMixin<ArticleModel>{
  final ArticleRepository repo;
  final UserRepository userRepo;
  List<ArticleModel>? newsData;
  final int catId;
  bool isFavoriteActive = false;
  List<int> topicIds = [0];

  ListNewsViewModel({required this.repo, required this.userRepo, required this.catId}) : super(repo) {
    loadingData();
  }

  @override
  Future<ApiResponse<ListResponse<List<ArticleModel>>>> getData() {
    return repo.getArticleByType(slug: Slug.newsPage, page: pagingRequest.page!);
  }

  @override
  void notifyData() {
    notifyListeners();
  }

  @override
  set notifyLoading(bool value) {
    setLoading = value;
  }

  void loadingData() async{
    await refreshData(needShowLoading: true);
    await getFavoriteStatus();
  }

  getFavoriteStatus({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    setLoading = true;
    final userResponse = await userRepo.getUserInfo();
    if (userResponse.isOk) {
      topicIds = userResponse.data!.topicOfInterestIds ?? [];
      if (topicIds.contains(catId)) {
        isFavoriteActive = true;
      } else {
        isFavoriteActive = false;
      }
    }
    setLoading = false;
  }
}