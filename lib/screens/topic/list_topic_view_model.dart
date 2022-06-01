import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/enum/slug.dart';
import 'package:dominhduong/model/category_model.dart';
import 'package:dominhduong/repository/firebase_repository.dart';
import 'package:flutter/cupertino.dart';
import '../../repository/user_repository.dart';
import '../../utils/toast_utils.dart';

class ListTopicViewModel extends BaseViewModel {
  List<CategoryModel> categories = [];
  List<int> topicIds = [0];

  final UserRepository repo;

  ListTopicViewModel({required this.repo}) : super(repo) {
    getPageData();
  }

  getPageData({VoidCallback? onLoadedCallback}) async {
    setLoading = true;
    final response = await repo.getWidgetsBySlug(Slug.listTopicPage);
    if (response.isOk) {
      categories = response.data?.categories ?? [];
    }
    final response1 = await repo.getUserInfo();
    if (response1.isOk) {
      topicIds = response1.data!.topicOfInterestIds ?? [];
      for (CategoryModel cat in categories) {
        if (topicIds.contains(cat.id)) {
          cat.isSelected = true;
        } else {
          cat.isSelected = false;
        }
      }
    }
    onLoadedCallback?.call();
    setLoading = false;
    notifyListeners();
  }

  registerTopic({SuccessCallback? successCallback, ErrorCallback? errorCallback}) async {
    setLoading = true;
    List<String> ids = categories.where((element) => element.isSelected).map((e) => e.id!.toString()).toList();
    if(ids.isEmpty) {
      ids.add('0');
    }
    final response = await repo.registerTopic(ids).catchError((onError) {
      setLoading = false;
      showMessage('Có lỗi hệ thống xảy ra!');
    });
    if (response.isOk) {
      successCallback?.call(null);
    } else {
      errorCallback?.call(response.message);
    }
    setLoading = false;
    notifyListeners();
  }

  updateData() {
    notifyListeners();
  }
}
