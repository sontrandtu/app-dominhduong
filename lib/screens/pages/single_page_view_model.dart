import 'package:dominhduong/model/widget_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/enum/slug.dart';
import '../../repository/widget_repository.dart';

class SinglePageViewModel extends BaseViewModel {
  final Slug slug;
  WidgetModel? page;

  final WidgetRepository repo;

  SinglePageViewModel({required this.repo, required this.slug}) : super(repo) {
    getPageData();
  }

  getPageData({VoidCallback? onLoadedCallback}) async {
    setLoading = true;
    final response = await repo.getWidgetsBySlug(slug);
    if (response.isOk) {
      page = response.data;
    }
    onLoadedCallback?.call();
    setLoading = false;
  }
}
