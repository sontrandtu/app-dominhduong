import 'dart:io';

import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/enum/slug.dart';
import 'package:dominhduong/model/category_model.dart';
import 'package:dominhduong/model/order_medicine_model.dart';
import 'package:dominhduong/repository/home_repository.dart';
import 'package:dominhduong/repository/order_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../../repository/user_repository.dart';
import '../../model/user/user_info_model.dart';
import '../../utils/toast_utils.dart';

class OrderMedicineViewModel extends BaseViewModel {
  final OrderRepository orderRepo;
  OrderMedicineModel? orderMedicine;
  final HomeRepository homeRepo;
  final UserRepository userRepo;
  final File? selectedImage;
  UserInfoModel userInfoModel = UserInfoModel();

  List<CategoryModel> listCategory = [];

  OrderMedicineModel orderMedicineModel = OrderMedicineModel(isHavePrescription: false, state: 'confirmed',quantity: 1);
  String birthday = '';

  OrderMedicineViewModel({required this.orderRepo, required this.userRepo, required this.homeRepo, this.orderMedicine, this.selectedImage}) : super(orderRepo) {
    loadData();
  }

  set updateBirthDay(String value) {
    birthday = value;
    notifyListeners();
  }

  bool isValidate(dynamic input){
    if(input == null){
      return true;
    }
    return false;
  }

  bool updatePrescription(String prescription){
    return (prescription == 'Đã có đơn thuốc') ? true : false;
  }

  String updatePaymentType(String? payment) {
    return payment == 'Tiền mặt' ? 'cash' : 'bank';
  }

  loadData({VoidCallback? onLoadedCallBack, ErrorCallback? errorCallBack}) async {
    setLoading = true;

    await loadUserInfo();

    await homeRepo.getWidgetsBySlug(Slug.listTopicPage).then((value) {
      if(value.isOk){
        listCategory = value.data?.categories ?? [];
      } else {
        errorCallBack?.call(value.message);
      }
      notifyListeners();
    });

    setLoading = false;
  }

  loadUserInfo({SuccessCallback? successCallback, ErrorCallback? errorCallback}) async {
    await userRepo.getUserInfo().then((response) {
      if (response.isOk) {
        userInfoModel = response.data!;
        setBookingUser(info: userInfoModel);
      } else {
        errorCallback?.call(response.message);
      }
    });
  }

  setBookingUser({required UserInfoModel info}) {
    orderMedicineModel.receiverName = info.name ?? '';
    orderMedicineModel.receiverPhone = info.phone ?? '';
    birthday = info.birthday ?? '';

    notifyListeners();
  }

  createOrderMedicine({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    setLoading = true;
    final response = await orderRepo.createOderMedicine(orderMedicineModel: orderMedicine, image: selectedImage).catchError((onError) {
      setLoading = false;
      showMessage('Có lỗi hệ thống xảy ra!');
    });
    if (response.isOk) {
      successCallback?.call('Đặt mua thuốc thành công!');
    } else {
      errorCallback?.call(response.message);
    }
    setLoading = false;
  }
}
