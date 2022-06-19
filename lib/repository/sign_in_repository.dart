import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/login_response.dart';
import 'package:dominhduong/model/user_info_model.dart';
import 'package:dominhduong/repository/repository.dart';

class SignInRepository extends Repository {

  Future<ApiResponse<LoginResponse>> login(String phoneNumber) async {
    return await apiClient!.login(phone: phoneNumber).wrap();
  }

  Future<ApiResponse<UserInfoModel>> verifyOTP({required String phoneNumber, required String otp}) async {
    return await apiClient!.verifyOTP(phone: phoneNumber, otp: otp).wrap();
  }

}
