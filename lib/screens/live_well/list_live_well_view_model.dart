import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/enum/slug.dart';
import 'package:flutter/cupertino.dart';
import '../../model/category_model.dart';
import '../../repository/home_repository.dart';
import '../../repository/user_repository.dart';

class ListLiveWellViewModel extends BaseViewModel{
  final HomeRepository repo;
  List<CategoryModel> categories = [];

  final UserRepository userRepo;

  ListLiveWellViewModel({required this.repo, required this.userRepo}) : super(repo){
    getData();
  }

  getData({VoidCallback? onLoadedCallBack}) async{
    setLoading = false;
    final response = await repo.getWidgetsBySlug(Slug.listTopicPage);
    if(response.isOk){
      categories.addAll(response.data?.categories ?? []);
    }
    onLoadedCallBack?.call();
    setLoading = false;
  }
}
