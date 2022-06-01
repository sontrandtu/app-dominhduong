import 'package:dominhduong/api/dio_helper.dart';
import 'package:dominhduong/api/res_client.dart';
import 'package:dominhduong/preference/preference.dart';

class Repository {
  RestClient? apiClient;

  Repository() {
    apiClient = RestClient(DioHelper.dioObject!);
  }

  String? get accessToken => PreferenceManager.getValue<String>(PreferenceManager.KEY_ACCESS_TOKEN);

  String? get userId => PreferenceManager.getValue<String>(PreferenceManager.KEY_USER_ID);
}
