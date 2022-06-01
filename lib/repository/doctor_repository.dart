import 'package:dominhduong/api/api_config.dart';
import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/model/doctor_model.dart';
import 'package:dominhduong/model/user/user_info_model.dart';
import 'package:dominhduong/repository/repository.dart';

class DoctorRepository extends Repository {
  Future<ApiResponse<ListResponse<List<DoctorModel>>>> getListDoctor(int page, {int limit = ApiConfig.pageSize}) async {
    return await apiClient!.getListDoctor(page: page, limit: limit).wrap();
  }

  Future<ApiResponse<ListResponse<List<DoctorModel>>>> getAllDoctor() async {
    return await apiClient!.getAllDoctor().wrap();
  }

  Future<ApiResponse<ListResponse<List<DoctorModel>>>> getDoctorsByBranch(int? branchId) async {
    return await apiClient!.getDoctorsByBranch(id: branchId!).wrap();
  }

  Future<ApiResponse<DoctorModel>> getDoctorDetail(int id) async {
    return await apiClient!.getDoctorDetail(id: id).wrap();
  }

  Future<ApiResponse<UserInfoModel>> getUserInfo() async {
    return await apiClient!.getUserInfo().wrap();
  }
}
