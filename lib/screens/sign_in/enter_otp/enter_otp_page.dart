import 'dart:async';
import 'package:dominhduong/page_routes.dart';
import 'package:dominhduong/res.dart';
import 'package:dominhduong/screens/sign_in/enter_otp/enter_otp_view_model.dart';
import 'package:dominhduong/screens/sign_in/enter_phone_number/enter_phone_number_page.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/utils/extensions.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';


import '../../../global_key.dart';
import '../../../repository/booking_repository.dart';
import '../../../repository/home_repository.dart';
import '../../history/list_history_view_model.dart';
import '../../main_page/tabs/home/home_view_model.dart';
class EnterOTPPage extends StatefulWidget {
  const EnterOTPPage({Key? key}) : super(key: key);

  @override
  State<EnterOTPPage> createState() => _EnterOTPPageState();
}

class _EnterOTPPageState extends State<EnterOTPPage> {
  TextEditingController textEditingController = TextEditingController();
  late StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EnterOTPViewModel>();
    viewModel.context = context;
    textEditingController.text = viewModel.otp;

    return CoverLoading(
      showLoading: viewModel.isLoading,
      isStack: true,
      child: GestureDetector(
        onTap: () {
          context.hideKeyboard();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Column(
                children: [Image.asset(Res.image_login_background_1)],
              ),
              SafeArea(
                child: SingleChildScrollView(
                  reverse: true,
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Center(
                        child: Text('XÁC NHẬN OTP', style: context.textStyle(color: AppColors.secondaryColor).size18.w700.fontRobotoSlab),
                      ),
                      const SizedBox(height: 100),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: SvgPicture.asset(Res.image_logo_2),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Mã xác nhận được gửi về thuê bao',
                        style: context.textStyle(color: Colors.black).w700.fontRobotoSlab,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        viewModel.phoneNumber,
                        style: context.textStyle(color: const Color(0xffd7a444)).w700.size16,
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: PinCodeTextField(
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          keyboardType: TextInputType.phone,
                          textStyle: TextStyle(color: AppColors.primaryColor),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          pinTheme: PinTheme.defaults(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8.0),
                            fieldHeight: 40,
                            fieldWidth: 40,
                            activeColor: AppColors.pinCodeTextFieldColor,
                            inactiveColor: AppColors.inactiveButton,
                            selectedColor: AppColors.pinCodeTextFieldColor,
                            inactiveFillColor: AppColors.inactiveButton,
                            activeFillColor: AppColors.pinCodeTextFieldColor,
                            selectedFillColor: AppColors.pinCodeTextFieldColor,
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,

                          errorAnimationController: errorController,
                          // controller: textEditingController,
                          onChanged: (value) {
                            textEditingController.text = value;
                            viewModel.otp = value;
                            setState((){});
                          },

                          appContext: context,
                        ),
                      ),
                      const SizedBox(height: 5),
                      viewModel.isExpired
                          ? Text('Mã OTP hết hạn', style: context.textStyle(color: const Color(0xffd7a444)).w700.size14.fontRobotoSlab)
                          : Text('Mã OTP hết hạn sau ${viewModel.remainingTime}s', style: context.textStyle(color: const Color(0xffd7a444)).w700.size14.fontRobotoSlab),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: GestureDetector(
                          onTap: () {
                            textEditingController.text = '';
                            viewModel.resendOTP();
                          },
                          child: Visibility(
                            visible: viewModel.isExpired,
                            child: Text(
                              'Gửi lại OTP',
                              style: context.textStyle(color: Colors.red).size14.fontRobotoSlab,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: SolidButton(
                                text: 'XÁC NHẬN',
                                isActive: !viewModel.isExpired && viewModel.otp.length == 6,
                                onPressed: () {
                                  viewModel.verifyOTP(errorCallback: (message) {
                                    context.showMessage(message, type: MessageType.error);
                                  }, successCallback: (message) async{
                                    homeVM = HomeViewModel(homeRepo: HomeRepository());
                                    historyVM = ListHistoryViewModel(repo: BookingRepository());
                                    Navigator.pushNamedAndRemoveUntil(context, PageRoutes.main, ModalRoute.withName(PageRoutes.enterPhoneNumber));
                                    //show dialog
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
