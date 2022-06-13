import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/enum/slug.dart';
import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/model/doctor_model.dart';
import 'package:dominhduong/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends BaseViewModel {
  List<String> slideImages = [];
  List<DoctorModel> doctors = [];
  List<ArticleModel> topicsOfInterest = [];
  List<ArticleModel> medicineServices = [];
  List<ArticleModel> medicines = [];
  List<ArticleModel> news = [];
  int newsId = 0;

  final HomeRepository homeRepo;

  HomeViewModel({required this.homeRepo}) : super(homeRepo) {
    loadData();
  }

  loadData({VoidCallback? onLoadedCallback, ErrorCallback? errorCallback}) async {
    homeRepo.getWidgetsBySlug(Slug.homeSlide).then((value) {
      if(value.isOk){
        slideImages = value.data?.arrImageUrl ?? [];
      }else{
        errorCallback?.call(value.message);
      }
      notifyListeners();
    });

    homeRepo.getWidgetsBySlug(Slug.homeTeamOfDoctors).then((value) {
      if (value.isOk) {
        doctors = value.data?.doctors ?? [];
      } else {
        errorCallback?.call(value.message);
      }
      notifyListeners();
    });

    homeRepo.getWidgetsBySlug(Slug.homeServices).then((value) {
      if (value.isOk) {
        medicineServices = value.data?.articles ?? [];
      } else {
        errorCallback?.call(value.message);
      }
      notifyListeners();
    });

    homeRepo.getWidgetsBySlug(Slug.homeTraditionalMedicine).then((value) {
      if (value.isOk) {
        medicines = value.data?.articles ?? [];
      } else {
        errorCallback?.call(value.message);
      }
      notifyListeners();
    });

    homeRepo.getWidgetsBySlug(Slug.homeNews).then((value) {
      if (value.isOk) {
        newsId = value.data?.categoryId ?? 0;
        news = value.data?.articles ?? [];
      } else {
        errorCallback?.call(value.message);
      }
      notifyListeners();
    });

    loadHomeTopic();

    onLoadedCallback?.call();
  }

  loadHomeTopic({SuccessCallback? successCallback, ErrorCallback? errorCallback}) async{
    await homeRepo.getWidgetsBySlug(Slug.homeTopicsOfInterest).then((value) {
      if(value.isOk){
        topicsOfInterest = value.data?.articles ?? [];
        successCallback?.call('');
      }else{
        errorCallback?.call(value.message);
      }
      notifyListeners();
    });
  }
}
