import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/repository/sign_in_repository.dart';

class EnterPhoneNumberViewModel extends BaseViewModel {
  String phoneNumber = '';
  String email = '';
  String password = '';

  final SignInRepository repo;

  EnterPhoneNumberViewModel(this.repo) : super(repo);

  login({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    setLoading = true;
    // if(kDebugMode){
    //   updateEmail ='0943574556';
    // }
    final response = await repo.login(phoneNumber);
    if (response.isOk) {
      successCallback?.call(response.data!.otp);
    } else {
      errorCallback?.call(response.message);
    }
    setLoading = false;
  }

  set updatePhone(String phone) {
    phoneNumber = phone;
    notifyListeners();
  }

  set updateEmail(String emailText) {
    email = emailText;
    notifyListeners();
  }

  set updatePassword(String passwordText) {
    password = passwordText;
    notifyListeners();
  }

  bool get isInvalidDoctor => email.length > 10;

  bool get isInvalid => phoneNumber.length > 9;

}
