import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/repository/repository.dart';
import '../model/branch_model.dart';

class HotlineRepository extends Repository {
  Future<ApiResponse<ListResponse<List<BranchModel>>>> getBranches() async {
    return await apiClient!.getBranches(children: 1).wrap();
  }
}
