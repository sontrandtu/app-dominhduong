import 'package:dominhduong/enum/slug.dart';
import 'package:dominhduong/model/category_model.dart';
import 'package:dominhduong/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:dominhduong/base/base_view_model.dart';

class ListVideoViewModel extends BaseViewModel {
  final HomeRepository repo;
  List<CategoryModel> categories = [];

  ListVideoViewModel(this.repo) : super(repo) {
    getData();
  }

  getData({VoidCallback? onLoadedCallback}) async {
    setLoading = true;
    final response = await Future.wait([
      repo.getWidgetsBySlug(Slug.videosPage)
    ]);
    if (response[0].isOk) {
      categories.addAll(response[0].data?.categories ?? []);
    }
    onLoadedCallback?.call();
    setLoading = false;
  }
}
