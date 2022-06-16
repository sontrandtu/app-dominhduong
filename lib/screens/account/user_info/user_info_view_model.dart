import 'dart:io';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/model/user/user_info_model.dart';
import 'package:dominhduong/repository/user_repository.dart';
import 'package:dominhduong/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../utils/toast_utils.dart';

class UserInfoViewModel extends BaseViewModel{
  final UserRepository userRepo;
  bool loadFistTime = true;
  bool isProvince = false;
  bool isDistrict = false;
  bool isWard = false;
  UserInfoModel? userInfoModel = UserInfoModel();
  File? selectedImageFile;
  GlobalKey<FormState>? relativeFormKey;
  BuildContext? context;
  List<String> genders = ['Nam', 'Nữ'];
  int? initGender;

  UserInfoViewModel({required this.userRepo}) : super(userRepo){
    loadData();
  }

  loadData() async {
    setLoading = true;
    await getAccountInfo();
    setLoading = false;
  }

  updateBirthday(String date){
    userInfoModel?.birthday = date;
    notifyListeners();
  }

  checkGender(String? gender){
    if(gender == 'male'){
      initGender = 0;
    } else if(gender == 'female'){
      initGender = 1;
    } else{
      initGender = null;
    }
  }

  String? updateGender(String? gender){
    return (gender == 'Nam') ? 'male' : 'female';
  }

  bool isValidate(dynamic input){
    if(input == null || input == 0){
      return true;
    }
    return false;
  }

  getAccountInfo() async {
    setLoading = true;
    final response = await userRepo.getUserInfo().catchError((onError) {setLoading = false;});
    if(response.isOk){
      userInfoModel = response.data!;
      checkGender(userInfoModel?.gender);
    }
    setLoading = false;
  }

  updateUserInfo({SuccessCallback? successCallback, ErrorCallback? errorCallback}) async {
    setLoading = true;
    final response = await userRepo.updateUserInfo(image: selectedImageFile, userInfoModel: userInfoModel!).catchError((onError) {
      setLoading = false;
      showMessage('Có lỗi hệ thống xảy ra!');
    });
    if (response.isOk) {
      userInfoModel = response.data;
      successCallback?.call(userInfoModel);
    } else {
      errorCallback?.call(response.message);
    }
    setLoading = false;
  }

  onUpdateData() {
    setLoading = true;
    if(relativeFormKey!.currentState!.validate()
        && userInfoModel?.provinceId != null
        && userInfoModel?.districtId != null
        && userInfoModel?.wardId != null
        && userInfoModel?.gender != null
        && userInfoModel?.street != null){
      updateUserInfo(
          successCallback: (value) async{
            context!.showMessage('Cập nhật hồ sơ cá nhân thành công!',type: MessageType.success);
            Navigator.of(context!).pop();
          },
          errorCallback: (error) {
            context!.showMessage(error,type: MessageType.error);
          }
      );
      notifyListeners();
    } else {
      isProvince = isValidate(userInfoModel?.provinceId);
      isDistrict = isValidate(userInfoModel?.districtId);
      isWard = isValidate(userInfoModel?.wardId);
      context!.showMessage("Bạn vui lòng điền đầy đủ thông tin!", type: MessageType.error);
    }
    setLoading = false;
  }

  updateData(){
    notifyListeners();
  }
}