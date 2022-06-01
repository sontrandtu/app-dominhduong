import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/enum/slug.dart';
import 'package:dominhduong/model/user/user_info_model.dart';
import 'package:dominhduong/repository/repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/widget_model.dart';

class FirebaseRepository extends Repository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  FirebaseRepository({required this.firebaseFirestore, required this.firebaseStorage});

  Future<ApiResponse<dynamic>> registerFCMToken(String? token) async {
    return await apiClient!.registerFCMToken(fcmToken: token).wrap();
  }



  Future<ApiResponse<UserInfoModel>> getUserInfo() async {
    return await apiClient!.getUserInfo().wrap();
  }
}
