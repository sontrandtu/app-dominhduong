
import 'package:dominhduong/repository/repository.dart';

import '../api/api_response.dart';
import '../api/response_model/list_response.dart';
import '../model/location_model.dart';

class LocationRepository extends Repository{

  Future<ApiResponse<ListResponse<List<LocationModel>>>> getListProvince() async {
    return await apiClient!.getListProvince().wrap();
  }

  Future<ApiResponse<ListResponse<List<LocationModel>>>> getListDistrict(int? provinceId) async {
    return await apiClient!.getListDistrict(provinceId: provinceId).wrap();
  }

  Future<ApiResponse<ListResponse<List<LocationModel>>>> getListWard(int? districtId) async {
    return await apiClient!.getListWard(districtId: districtId).wrap();
  }
}