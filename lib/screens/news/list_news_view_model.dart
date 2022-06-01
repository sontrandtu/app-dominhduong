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
  String keyword = '';
  bool isFavoriteActive = false;
  List<int> topicIds = [0];

  ListNewsViewModel({required this.repo, required this.userRepo, required this.catId}) : super(repo) {
    LoadingData();
  }

  @override
  Future<ApiResponse<ListResponse<List<ArticleModel>>>> getData() {
    return repo.getArticleByType(keyword: keyword, slug: Slug.newsPage, page: pagingRequest.page!);
  }

  @override
  void notifyData() {
    notifyListeners();
  }

  @override
  set notifyLoading(bool value) {
    setLoading = value;
  }

  void LoadingData() async{
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

  registerTopic({required String type, SuccessCallback? successCallback, ErrorCallback? errorCallback}) async {
    List<String> ids = topicIds.map((item) => item.toString()).toList();
    var cId = catId.toString();

    if(type == 'remove') {
      ids.remove(cId);
      if(ids.isEmpty) {
        ids.add('0');
      }
    }

    if(type == 'add' && !ids.contains(cId)) ids.add(cId);

    final response = await userRepo.registerTopic(ids);
    if (response.isOk) {
      successCallback?.call(null);
    } else {
      errorCallback?.call(response.message);
    }
  }
}