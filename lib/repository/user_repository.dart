import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/model/user/user_info_model.dart';
import 'package:dominhduong/preference/preference.dart';
import 'package:dominhduong/repository/repository.dart';

import '../enum/slug.dart';
import '../model/widget_model.dart';

class UserRepository extends Repository {
  Future<bool> logout() async {
    return await PreferenceManager.setValue<String>(PreferenceManager.KEY_ACCESS_TOKEN, '');
  }

  Future<ApiResponse<UserInfoModel>> getUserInfo() async {
    return await apiClient!.getUserInfo().wrap();
  }

  Future<ApiResponse<WidgetModel>> getWidgetsBySlug(Slug slug) async {
    return await apiClient!.getWidgetsBySlug(slug: slug.stringValue).wrap();
  }

  Future<ApiResponse> logOut() async {
    return await apiClient!.logOut().wrap();
  }

  Future<ApiResponse<UserInfoModel>> updateUserInfo({required File? image, required UserInfoModel userInfoModel}) async {
    return await apiClient!.updateUserInfo(
      image: image,
      username: userInfoModel.name,
      phone: userInfoModel.phone,
      birthday: userInfoModel.birthday,
      address: userInfoModel.street,
      gender: userInfoModel.gender,
      provinceId: userInfoModel.provinceId,
      districtId: userInfoModel.districtId,
      wardId: userInfoModel.wardId,
    ).wrap();
  }

  Future<ApiResponse<UserInfoModel>> updateAvatar({required File file, ProgressCallback? callback}) async {
    return await apiClient!.updateAvatar(image: file, callback: callback).wrap();
  }
}
