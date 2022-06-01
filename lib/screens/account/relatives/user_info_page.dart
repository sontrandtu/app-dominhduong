
import 'package:dominhduong/screens/account/relatives/user_info_view_model.dart';
import 'package:dominhduong/utils/extensions.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/fields/dropdown/custom_dropdown_button.dart';
import 'package:dominhduong/widgets/fields/location/location_view_model.dart';
import 'package:dominhduong/widgets/fields/location/location_widget.dart';
import 'package:dominhduong/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../theme/colors.dart';
import '../../../utils/dialog_utils.dart';
import '../../../widgets/custom_cached_network_image.dart';
import '../../../widgets/fields/custom_radio_button.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final GlobalKey<FormState> _relativeFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserInfoViewModel>();
    viewModel.relativeFormKey = _relativeFormKey;
    viewModel.context = context;
    return GestureDetector(
      onTap: () {
        context.hideKeyboard();
      },
      child: Scaffold(
        appBar: PageAppBarComp(title: "Thông tin cá nhân".toUpperCase(), canPop: true),
        backgroundColor: const Color(0xFFF6F6F6),
        body: CoverLoading(
          isStack: true,
          showLoading: viewModel.isLoading,
          // showLoading: false,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _relativeFormKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 0, bottom: 20),
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheetImage(
                              context: context,
                              imageCallBack: (image) {
                                if (image != null) {
                                  setState(() {
                                    viewModel.selectedImageFile = File(image);
                                  });
                                }
                              },
                            );
                          },
                          child: Stack(
                            children: [
                              viewModel.selectedImageFile != null
                                  ? Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 2.0, color: AppColors.textPrimaryColor),
                                  ),
                                  child: CircleAvatar(
                                    radius: 200,
                                    backgroundImage: FileImage(viewModel.selectedImageFile!),
                                    backgroundColor: AppColors.secondaryColor,
                                  ))
                                  : CustomNetworkImage(
                                  height: 90,
                                  width: 90,
                                  url: viewModel.userInfoModel?.imageUrl ?? '',
                                  isCircle: true,
                                  borderWidth: 2.0,
                                  isPlaceholderImage: false,
                                  borderColor: AppColors.grey),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary,
                                      shape: BoxShape.circle,
                                      border: Border.all(width: 4, color: Colors.white),
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomInputField(
                    labelWidget: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: '* ',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto',
                                  fontSize: 14)),
                          TextSpan(
                            text: 'Họ và tên',
                            style:
                            TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    prefixIcon: const Icon(Icons.edit_outlined, color: Colors.black54),
                    onChanged: (value) {
                      viewModel.userInfoModel?.name = value;
                    },
                    value: viewModel.userInfoModel?.name,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Vui lòng nhập họ tên";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      context.hideKeyboard();
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime.now(),
                          onChanged: (date) {},
                          onConfirm: (DateTime date) => viewModel.updateBirthday(date.dateTimeToDDMMYYYY),
                          currentTime: (viewModel.userInfoModel?.birthday == null)
                              ? DateTime.now()
                              : DateFormat('DD/MM/yyyy').parse(viewModel.userInfoModel?.birthday ?? ''),
                          locale: LocaleType.vi);
                    },
                    child: AbsorbPointer(
                      child: CustomInputField(
                        keyboardType: TextInputType.text,
                        labelWidget: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: '* ',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Roboto',
                                      fontSize: 14)),
                              TextSpan(
                                text: 'Ngày sinh',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        prefixIcon: const Icon(Icons.cake_outlined, color: Colors.black54),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập ngày sinh';
                          }
                          return null;
                        },
                        value: viewModel.userInfoModel?.birthday,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomInputField(
                    enabled: false,
                    labelWidget: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: '* ',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto',
                                  fontSize: 14)),
                          TextSpan(
                              text: 'Số điện thoại',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14)),
                        ],
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    prefixIcon: const Icon(Icons.call_outlined, color: Colors.black54),
                    onChanged: (value) {
                      viewModel.userInfoModel?.phone = value;
                    },
                    value: viewModel.userInfoModel?.phone,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Vui lòng nhập số điện thoại";
                      } else if (value.length < 10) {
                        return "Số điện thoại phải đủ 10 chữ số";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: !viewModel.isLoading || !viewModel.loadFistTime ? ChangeNotifierProvider(
                      create: (_) => LocationViewModel(
                        repo: context.watch(),
                        provinceId: viewModel.userInfoModel?.provinceId ?? -1,
                        districtId: viewModel.userInfoModel?.districtId ?? -1,
                        wardId: viewModel.userInfoModel?.wardId ?? -1,
                      ),
                      child: LocationWidget(
                          isDistrict: viewModel.isDistrict,
                          isSProvince: viewModel.isProvince,
                          districtId: viewModel.userInfoModel?.districtId ?? -1,
                          provinceId: viewModel.userInfoModel?.provinceId ?? -1,
                          wardId: viewModel.userInfoModel?.wardId ?? -1,
                          isWard: viewModel.isWard,
                          onSelectedProvinceCallback: (id) {
                            viewModel.userInfoModel?.provinceId = id;
                            viewModel.isProvince = viewModel.isValidate(viewModel.userInfoModel?.provinceId);
                            viewModel.updateData();
                          },
                          onSelectedDistrictCallback: (id) {
                            viewModel.userInfoModel?.districtId = id;
                            viewModel.isDistrict = viewModel.isValidate(viewModel.userInfoModel?.districtId);
                            viewModel.updateData();
                          },
                          onSelectedWardCallback: (id) {
                            viewModel.userInfoModel?.wardId = id;
                            viewModel.isWard = viewModel.isValidate(viewModel.userInfoModel?.wardId);
                            viewModel.updateData();
                          }),
                    ) : Column(children: const [
                      CustomDropdownButton(data: [], placeholderText: 'Tỉnh/Thành phố', type: 2),
                      CustomDropdownButton(data: [], placeholderText: 'Quận/Huyện', type: 2),
                      CustomDropdownButton(data: [], placeholderText: 'Xã/Phường', type: 2),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  CustomInputField(
                    labelWidget: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: '* ',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto',
                                  fontSize: 14)),
                          TextSpan(
                              text: 'Tên đường, toà nhà',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14)),
                        ],
                      ),
                    ),
                    keyboardType: TextInputType.streetAddress,
                    prefixIcon: const Icon(Icons.house_outlined, color: Colors.black54),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Vui lòng nhập địa chỉ cụ thể";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      viewModel.userInfoModel?.street = value;
                    },
                    value: viewModel.userInfoModel?.street,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w700),
                          children: [
                            TextSpan(text: 'Giới tính', style: TextStyle(color: Colors.black)),
                            TextSpan(text: ' * ', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  (viewModel.isLoading) ? const SizedBox() : CustomRadioButton(
                    data: viewModel.genders,
                    iconData: const [Icons.male_outlined, Icons.female_outlined],
                    initData: viewModel.initGender,
                    isIcon: true,
                    selectedCallBack: (gender) {
                      viewModel.userInfoModel?.gender = viewModel.updateGender(gender);
                    },
                  ),
                  const SizedBox(height: 31.5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        child: const Text('HOÀN TẤT', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Roboto')),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF3B2313),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          viewModel.loadFistTime = false;
                          viewModel.onUpdateData();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
