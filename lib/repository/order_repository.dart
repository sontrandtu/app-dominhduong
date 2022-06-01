import 'dart:io';
import 'package:dominhduong/api/api_config.dart';
import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/repository/repository.dart';
import '../model/order_medicine_model.dart';
import '../model/order_model.dart';

class OrderRepository extends Repository {
  Future<ApiResponse<ListResponse<List<OrderMedicineModel>>>> getListOrderMedicine(int page, {int limit = ApiConfig.pageSize}) async{
    return await apiClient!.getListOrderMedicine(page: page, limit: limit).wrap();
  }

  Future<ApiResponse<OrderMedicineModel>> createOderMedicine({required OrderMedicineModel? orderMedicineModel , required File? image}) async {
    return await apiClient!.createOrderMedicine(
      categoryId: orderMedicineModel?.categoryId,
      quantity: orderMedicineModel?.quantity,
      isHavePrescription: orderMedicineModel?.isHavePrescription,
      state: orderMedicineModel?.state,
      receiverName: orderMedicineModel?.receiverName,
      receiverPhone: orderMedicineModel?.receiverPhone,
      paymentType: orderMedicineModel?.paymentType,
      provinceId: orderMedicineModel?.provinceId,
      districtId: orderMedicineModel?.districtId,
      wardId: orderMedicineModel?.wardId,
      address: orderMedicineModel?.address,
      note: orderMedicineModel?.note,
      deliveryNote: orderMedicineModel?.deliveryNote,
      prescriptionImage: image,
    ).wrap();
  }

  Future<ApiResponse<ListResponse<List<OrderModel>>>> getListOder(
      int? examinationCardId, int page,
      {int limit = ApiConfig.pageSize}) async {
    return apiClient!.getListOder(page: page, limit: limit).wrap();
  }

}
