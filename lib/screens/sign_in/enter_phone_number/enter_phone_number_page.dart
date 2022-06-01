import 'package:dominhduong/page_routes.dart';
import 'package:dominhduong/res.dart';
import 'package:dominhduong/screens/sign_in/enter_phone_number/enter_phone_number_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:dominhduong/utils/extensions.dart';

class EnterPhoneNumberPage extends StatefulWidget {
  const EnterPhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<EnterPhoneNumberPage> createState() => _EnterPhoneNumberPageState();
}

class _EnterPhoneNumberPageState extends State<EnterPhoneNumberPage> {

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EnterPhoneNumberViewModel>();
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
              Image.asset(Res.image_login_background_1),
              SafeArea(
                child: SingleChildScrollView(
                  reverse: true,
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30),
                      Text('ĐĂNG NHẬP', textAlign: TextAlign.center, style: context.textStyle(color: AppColors.secondaryColor).size18.w700.fontRobotoSlab),
                      const SizedBox(height: 100),
                      SizedBox(
                        width: 96,
                        height: 96,
                        child: SvgPicture.asset(Res.image_logo_2),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomInputField(
                                maxLength: 12,
                                keyboardType: TextInputType.phone,
                                formatters: [FilteringTextInputFormatter.digitsOnly],
                                labelWidget: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: 'Số điện thoại',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14)),
                                    ],
                                  ),
                                ),
                                prefixIcon: const Icon(Icons.phone_outlined, color: Colors.grey),
                                onChanged: (value) {
                                  viewModel.updatePhone = value;
                                },
                              ),
                            ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: SolidButton(
                                      text: 'ĐĂNG NHẬP',
                                      onPressed: () {
                                        context.hideKeyboard();
                                        viewModel.login(errorCallback: (message) {
                                          context.showMessage(message, type: MessageType.error);
                                        }, successCallback: (value) {
                                          Navigator.pushNamed(context, PageRoutes.enterOTP, arguments: [viewModel.phoneNumber, value]);
                                        });
                                      },
                                      isActive: viewModel.isInvalid,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      ),

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

class SolidButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onPressed;

  const SolidButton({Key? key, required this.text, this.isActive = true, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (isActive) onPressed.call();
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 10)),
            backgroundColor: MaterialStateProperty.all<Color>(isActive ? AppColors.secondaryColor : AppColors.secondaryColor.withOpacity(0.4)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
        child: Text(
          text,
          style: context.textStyle(color: AppColors.textWhite).size16.w700.fontRobotoSlab,
        ),
    );
  }
}

class OutlineButton extends StatelessWidget {
  final String text;
  final bool needShowBorder;
  final VoidCallback onPressed;

  const OutlineButton({Key? key, required this.text, this.needShowBorder = true, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (needShowBorder) onPressed.call();
        },
        style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide?>(BorderSide(width: 1.0, color: needShowBorder ? Colors.transparent : Colors.blue)),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ))),
        child: Text(
          text,
          style: context.textStyle(color: AppColors.textBlack).size16.w400.fontRoboto,
        )
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EnterPhoneNumberViewModel>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomInputField(
            label: 'Email',
            validator: (value) => value!.isValidEmail ? null : "Check your email",
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              viewModel.updateEmail = value;
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomInputField(
            label: 'Password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {
              viewModel.updatePassword = value;
            },
          ),
        ),
      ],
    );
  }
}
