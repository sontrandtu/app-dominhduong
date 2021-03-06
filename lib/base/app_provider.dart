import 'package:dominhduong/enum/bottom_bar_type.dart';
import 'package:dominhduong/model/user_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import '../repository/home_repository.dart';

class AppProvider extends ChangeNotifier {
  UserInfoModel? userInfoModel;
  HomeRepository? homeRepository;

  set navigateTo(TabType tabType) {
    navigateToTab.add(tabType);
  }

  set updateUserInfo(UserInfoModel? userInfoModel) {
    this.userInfoModel = userInfoModel;
    notifyListeners();
  }

  final BehaviorSubject<TabType> navigateToTab = BehaviorSubject<TabType>();

  Stream<TabType> get navigateToTabStream => navigateToTab.stream;

  @override
  void dispose() {
    navigateToTab.close();
    super.dispose();
  }
}
