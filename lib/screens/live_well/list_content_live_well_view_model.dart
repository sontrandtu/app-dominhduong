import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/base/loadmore_mixin.dart';
import 'package:dominhduong/repository/article_repository.dart';
import 'package:dominhduong/repository/user_repository.dart';
import '../../model/article_model.dart';

class ListContentLiveWellViewModel extends BaseViewModel with LoadMoreMixin<ArticleModel>{
  final ArticleRepository repo;
  final int categoryId;
  String? keyword;
  final UserRepository userRepo;
  List<int> topicIds = [];

  ListContentLiveWellViewModel({required this.repo, required this.userRepo, required this.categoryId}) : super(repo){
    refreshData(needShowLoading: true);
  }

  @override
  Future<ApiResponse<ListResponse<List<ArticleModel>>>> getData() {
    return repo.getArticleByCategoryAndType(keyword: keyword, id: categoryId, page: pagingRequest.page!, type: 'song-khoe');
  }

  @override
  void notifyData() {
    notifyListeners();
  }

  @override
  set notifyLoading(bool value) {
    setLoading = value;
  }

  getFavoriteStatus(int catId, {ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    final userResponse = await userRepo.getUserInfo();
    if (userResponse.isOk) {
      topicIds = userResponse.data!.topicOfInterestIds ?? [];
      if (userResponse.isOk) {
        if (topicIds.contains(categoryId)) {
          successCallback?.call(true);
        } else {
          successCallback?.call(false);
        }
      } else {
        errorCallback?.call(userResponse.message);
      }
    }
  }

  registerTopic({required String type, SuccessCallback? successCallback, ErrorCallback? errorCallback}) async {
    List<String> ids = topicIds.map((item) => item.toString()).toList();
    var cId = categoryId.toString();

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