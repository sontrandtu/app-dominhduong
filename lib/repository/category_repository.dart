import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/model/category_model.dart';
import 'package:dominhduong/repository/repository.dart';

class CategoryRepository extends Repository {
  Future<ApiResponse<ListResponse<List<CategoryModel>>>> getListCategory(int id) async {
    return await apiClient!.getListCategory(id: id).wrap();
  }

  Future<ApiResponse<CategoryModel>> getCategoryDetail(int id) async {
    return await apiClient!.getCategoryDetail(id: id).wrap();
  }

}
