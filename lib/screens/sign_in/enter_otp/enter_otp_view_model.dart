import 'dart:async';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/preference/preference.dart';
import 'package:dominhduong/repository/sign_in_repository.dart';
import 'package:flutter/material.dart';

import '../../../utils/extensions/context_extension.dart';

const int timerOTP = 60;

class EnterOTPViewModel extends BaseViewModel {
  final String phoneNumber;
  String otp = '';
  BuildContext? context;

  final SignInRepository repo;

  EnterOTPViewModel({required this.repo, required this.phoneNumber, required this.otp}) : super(repo) {
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context!.showMessage(otp, type: MessageType.success);
    });
  }

  set updateOtp(String value) {
    otp = value;
    notifyListeners();
  }

  late Timer _timer;
  int start = timerOTP;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          notifyListeners();
          timer.cancel();
        } else {
          notifyListeners();
          start--;
        }
      },
    );
  }
  String get remainingTime {
    return start < 10 ? '0$start' : '$start';
  }

  bool get isExpired {
    return start == 0;
  }

  resendOTP() async {
    start = timerOTP;
    startTimer();
    final response = await repo.login(phoneNumber);
    if (response.isOk) {
      otp = response.data!.otp!;
    } else {}
  }

  verifyOTP({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    setLoading = true;
    final response = await repo.verifyOTP(phoneNumber: phoneNumber, otp: otp);
    if (response.isOk) {
      await PreferenceManager.setValue<String>(PreferenceManager.KEY_ACCESS_TOKEN, response.data!.token!);
      await PreferenceManager.setValue<String>(PreferenceManager.KEY_USER_ID, '${response.data!.id}');
      successCallback?.call('Đăng nhập thành công');
    } else {
      errorCallback?.call(response.message);
    }
    setLoading = false;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
