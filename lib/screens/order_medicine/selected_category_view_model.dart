
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/model/category_model.dart';
import 'package:dominhduong/repository/category_repository.dart';

class SelectedCategoryViewModel extends BaseViewModel{
  final CategoryRepository repo ;
  final int? categoryId;

  List<CategoryModel> categories = [];
  String header = '';

  SelectedCategoryViewModel({required this.repo, required this.categoryId}) : super(repo){
    loadCategories();
  }
  loadCategories() async {
    setLoading = true;
    final response = await repo.getListCategory(categoryId!);
    if(response.isOk){
      categories.addAll(response.data!.items ?? []);
      header = categories[0].name!;
    }
    setLoading = false;
  }
}