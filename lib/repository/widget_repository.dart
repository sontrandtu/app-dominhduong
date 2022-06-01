import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/enum/slug.dart';
import 'package:dominhduong/model/widget_model.dart';
import 'package:dominhduong/repository/repository.dart';

class WidgetRepository extends Repository {
  Future<ApiResponse<WidgetModel>> getWidgetsBySlug(Slug slug) async {
    return await apiClient!.getWidgetsBySlug(slug: slug.stringValue).wrap();
  }
}
