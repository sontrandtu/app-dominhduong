import 'dart:io';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/model/user_info_model.dart';
import 'package:dominhduong/repository/user_repository.dart';

class AccountTabViewModel extends BaseViewModel {
  final UserRepository repo;
  UserInfoModel? userInfoModel;

  AccountTabViewModel(this.repo,) : super(repo) {
    getAccountInfo();
  }

  updateAvatar(File image, {SuccessCallback? successCallback, ErrorCallback? errorCallback}) async {
    setLoading = true;
    final response = await repo.updateAvatar(file: image);
    if (response.isOk) {
      userInfoModel = response.data;
      successCallback?.call(response.data);
    } else {
      errorCallback?.call(response.message);
    }
    setLoading = false;
  }

  getAccountInfo() async {
    setLoading = true;
    final response = await repo.getUserInfo();
    if (response.isOk) {
      userInfoModel = response.data;
    }
    notifyListeners();
    setLoading = false;
  }

  logOut({SuccessCallback? successCallback, ErrorCallback? errorCallback}) async {
    // setLoading = true;
    // final response = await repo.logOut();
    // if (response.isOk) {
      successCallback?.call("Đăng xuất thành công");
    // } else {
    //   errorCallback?.call(response.message);
    // }
    // setLoading = false;
  }
}


