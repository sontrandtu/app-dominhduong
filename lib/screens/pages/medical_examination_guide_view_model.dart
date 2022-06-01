import 'package:flutter/cupertino.dart';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/enum/slug.dart';
import 'package:dominhduong/repository/widget_repository.dart';

class MedicalExaminationGuideViewModel extends BaseViewModel {
  String content = '';

  final WidgetRepository repo;

  MedicalExaminationGuideViewModel({required this.repo}) : super(repo) {
    getPageData();
  }

  getPageData({VoidCallback? onLoadedCallback}) async {
    setLoading = true;
    final response = await Future.wait([
      repo.getWidgetsBySlug(Slug.medicalExaminationGuidePage),
    ]);
    if (response[0].isOk) {
      content = response[0].data?.content ?? '';
    }
    onLoadedCallback?.call();
    setLoading = false;
  }
}
