enum Slug {
  homeSlide,
  homeServices,
  homeTraditionalMedicine,
  homeProduct,
  homeTeamOfDoctors,
  homeNews,
  homeTopicsOfInterest,
  homePopup,
  aboutPage,
  termsPolicyPage,
  complaintsPolicyPage,
  privacyPolicyPage,
  medicalExaminationGuidePage,
  liveWellPage,
  newsPage,
  listTopicPage,
  productPage,
  traditionalMedicinePage,
  servicesPage,
  videosPage,
}

extension SlugExtension on Slug{
  String get stringValue{
    switch (this) {
      case Slug.homeSlide:
        return 'slider-trang-chu';
      case Slug.homeServices:
        return 'dich-vu-trang-chu';
      case Slug.homeTraditionalMedicine:
        return 'bai-thuoc-gia-truyen-trang-chu';
      case Slug.homeProduct:
        return 'do-minh-gia-quy-trang-chu';
      case Slug.homeTeamOfDoctors:
        return 'bac-si-trang-chu';
      case Slug.homeNews:
        return 'tin-tuc-su-kien-trang-chu';
      case Slug.homeTopicsOfInterest:
        return 'chu-de-quan-tam-trang-chu';
      case Slug.homePopup:
        return 'popup-khuyen-mai';
      case Slug.aboutPage:
        return 'gioi-thieu';
      case Slug.termsPolicyPage:
        return 'chinh-sach-dieu-khoan';
      case Slug.complaintsPolicyPage:
        return 'chinh-sach-giai-quyet-khieu-nai';
      case Slug.privacyPolicyPage:
        return 'chinh-sach-quyen-rieng-tu';
      case Slug.medicalExaminationGuidePage:
        return 'huong-dan-kham-benh';
      case Slug.liveWellPage:
        return 'song-khoe';
      case Slug.newsPage:
        return 'tin-tuc-su-kien';
      case Slug.listTopicPage:
        return 'chuyen-khoa-dau-benh';
      case Slug.productPage:
        return 'do-minh-gia-quy';
      case Slug.traditionalMedicinePage:
        return 'bai-thuoc-dieu-tri';
      case Slug.servicesPage:
        return 'dich-vu';
      case Slug.videosPage:
        return 'danh-muc-videos';
    }
  }
}
