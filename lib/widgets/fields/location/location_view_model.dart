import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/repository/location_repository.dart';
import '../../../model/location_model.dart';

class LocationViewModel extends BaseViewModel{
  final LocationRepository repo;

  List<LocationModel> listProvince = [];
  List<LocationModel> listDistrict = [];
  List<LocationModel> listWard = [];

  bool loadFistTime = true;

  int provinceId = -1;
  int districtId = -1;
  int wardId = -1;

  String provinceName = 'Tỉnh/Thành phố';
  String districtName = 'Quận/Huyện';
  String wardName = 'Xã/Phường';

  LocationViewModel({required this.repo, required this.provinceId, required this.districtId, required this.wardId}) : super(repo){
    loadData();
  }

  loadData() async {
    setLoading = true;
    await loadProvince();
    if(provinceId > 0) await loadDistrict(provinceId);
    if(districtId > 0) await loadWard(districtId);
    setLoading = false;
  }

  loadProvince() async{
    final response = await repo.getListProvince();
    if(response.isOk){
      listProvince.clear();
      listDistrict.clear();
      listWard.clear();
      listProvince.addAll(response.data?.items ?? []);

      if(loadFistTime && provinceId > 0){
        int idx = listProvince.indexWhere((element) => element.id == provinceId);
        listProvince[idx].isSelected = true;
        provinceName = listProvince[idx].name;
      }
    }
    notifyListeners();
  }

  loadDistrict(int pId) async{
    final response = await repo.getListDistrict(pId);
    if(response.isOk){
      listDistrict.clear();
      listWard.clear();
      listDistrict.addAll(response.data?.items ?? []);

      if(loadFistTime && districtId > 0){
        int idx = listDistrict.indexWhere((element) => element.id == districtId);
        listDistrict[idx].isSelected = true;
        districtName = listDistrict[idx].name;
      }
    }
    notifyListeners();
  }

  loadWard(int dId) async{
    final response = await repo.getListWard(dId);
    if (response.isOk) {
      listWard.clear();
      listWard.addAll(response.data?.items ?? []);

      if(loadFistTime && wardId > 0){
        int idx = listWard.indexWhere((element) => element.id == wardId);
        listWard[idx].isSelected = true;
        wardName = listWard[idx].name;
      }
    }
    notifyListeners();
  }
}
