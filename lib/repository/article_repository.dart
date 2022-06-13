import 'package:dominhduong/api/api_config.dart';
import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/repository/repository.dart';
import 'package:dominhduong/enum/slug.dart';

class ArticleRepository extends Repository {
  Future<ApiResponse<ListResponse<List<ArticleModel>>>> getArticleByType({ required Slug slug, int page = 1, int limit = ApiConfig.pageSize}) async {
    return await apiClient!.getArticleByType(type: slug.stringValue, page: page, limit: limit).wrap();
  }

  Future<ApiResponse<ListResponse<List<ArticleModel>>>> getArticleByCategory(int id, int page, {int limit = ApiConfig.pageSize}) async {
    return await apiClient!.getArticleByCategory(id: id, page: page, limit: limit).wrap();
  }

  Future<ApiResponse<ListResponse<List<ArticleModel>>>> getArticleByCategoryAndType({String? keyword, required int id, int page = 1, required String type, int limit = ApiConfig.pageSize}) async {
    return await apiClient!.getArticleByCategoryAndType(keyword: keyword, id: id, page: page, limit: limit, type: type).wrap();
  }

  Future<ApiResponse<ListResponse<List<ArticleModel>>>> getArticleRelated(int id, int page, int limit) async {
    return await apiClient!.getArticleRelated(id: id, page: page, limit: limit).wrap();
  }

  Future<ApiResponse<ArticleModel>> getArticleDetail(int id) async {
    return await apiClient!.getArticleDetail(id: id).wrap();
  }
}
