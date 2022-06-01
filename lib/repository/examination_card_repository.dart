import 'package:dominhduong/api/api_config.dart';
import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/model/examination_card_model.dart';
import 'package:dominhduong/repository/repository.dart';

class ExaminationCardRepository extends Repository {
  Future<ApiResponse<ListResponse<List<ExaminationCardModel>>>> getListExaminationCard(int page, {int limit = ApiConfig.pageSize}) async {
    return await apiClient!.getListExaminationCard(page: page, limit: limit).wrap();
  }
}
