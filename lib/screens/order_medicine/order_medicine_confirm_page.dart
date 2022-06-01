import 'package:dominhduong/utils/extensions.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/fields/location/location_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../theme/colors.dart';
import '../../../widgets/fields/location/location_widget.dart';
import '../../../widgets/input_field.dart';
import '../../page_routes.dart';
import '../../utils/dialog_utils.dart';
import '../../widgets/fields/custom_radio_button.dart';
import 'order_medicine_view_model.dart';

class OrderMedicineConfirmPage extends StatefulWidget {
  const OrderMedicineConfirmPage({Key? key}) : super(key: key);

  @override
  _OrderMedicineConfirmPageState createState() => _OrderMedicineConfirmPageState();
}

class _OrderMedicineConfirmPageState extends State<OrderMedicineConfirmPage> {

  final GlobalKey<FormState> _orderConfirmKey = GlobalKey<FormState>();
  final TextEditingController _deliveryNoteController = TextEditingController();
  bool readOnly = true;
  bool isProvince = false;
  bool isDistrict = false;
  bool isWard = false;
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OrderMedicineViewModel>();
    return Scaffold(
      appBar: PageAppBarComp(title: 'ĐẶT THUỐC'),
      body: SafeArea(
        child: GestureDetector(
          onTap: (){context.hideKeyboard();},
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.only(top: 26, bottom: 25, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _orderConfirmKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 0, right: 0, bottom: 20, top: 0),
                          child: const Text('Thông tin người nhận hàng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Roboto', color: AppColors.textBlack)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomInputField(
                              maxLength: 32,
                              keyboardType: TextInputType.text,
                              labelWidget: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                    TextSpan(text: 'Họ và tên',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                                  ],
                                ),
                              ),
                              prefixIcon: const Icon(Icons.edit_outlined, color: Colors.black54),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập họ và tên';
                                }
                                return null;
                              },
                              onChanged: (String? value) {
                                viewModel.orderMedicine?.receiverName = value!.trim();
                              },
                              value: viewModel.orderMedicine!.receiverName,
                            ),
                            const SizedBox(height: 20),
                            CustomInputField(
                              keyboardType: TextInputType.number,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLength: 12,
                              labelWidget: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                    TextSpan(text: 'Số điện thoại',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                                  ],
                                ),
                              ),
                              prefixIcon: const Icon(Icons.phone, color: Colors.black54),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập số điện thoại';
                                } else if (value.length < 10) {
                                  return 'Số điện thoại phi lớn hơn 10 số';
                                }
                                return null;
                              },
                              onChanged: (String? value) {
                                viewModel.orderMedicine?.receiverPhone = value.toString().trim();
                              },
                              value: viewModel.orderMedicine!.receiverPhone,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ChangeNotifierProvider(
                                create: (_) => LocationViewModel(repo: context.watch(), provinceId: -1, districtId: -1, wardId: -1),
                                child: LocationWidget(
                                  isSProvince: isProvince,
                                  isDistrict: isDistrict,
                                  isWard: isWard,
                                  provinceId: viewModel.orderMedicine?.provinceId ?? -1,
                                  districtId: viewModel.orderMedicine?.districtId ?? -1,
                                  wardId: viewModel.orderMedicine?.wardId ?? -1,
                                  onSelectedProvinceCallback: (id){
                                    viewModel.orderMedicine?.provinceId = id;
                                    setState(() {
                                      isProvince = viewModel.isValidate(viewModel.orderMedicine?.provinceId);
                                    });
                                  },
                                  onSelectedDistrictCallback: (id){
                                    viewModel.orderMedicine?.districtId = id;
                                    setState(() {
                                      isDistrict = viewModel.isValidate(viewModel.orderMedicine?.districtId);
                                    });
                                  },
                                  onSelectedWardCallback: (id){
                                    viewModel.orderMedicine?.wardId = id;
                                    setState(() {
                                      isWard = viewModel.isValidate(viewModel.orderMedicine?.wardId);
                                    });
                                  },
                                ),
                              ),
                            ),
                            CustomInputField(
                              maxLength: 32,
                              keyboardType: TextInputType.text,
                              labelWidget: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                    TextSpan(text: 'Địa chỉ',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
                                  ],
                                ),
                              ),
                              prefixIcon: const Icon(Icons.edit_outlined, color: Colors.black54),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng nhập số nhà, tên đường';
                                }
                                return null;
                              },
                              onChanged: (String? value) {
                                viewModel.orderMedicine?.address = value!.trim();
                              },
                              value: viewModel.orderMedicine?.address ?? '',
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 32, bottom: 16),
                          child: Text('Ghi chú', style: TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w700,color: Colors.black)),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.only(bottom: 5),
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.withOpacity(0.5))
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              viewModel.orderMedicine?.deliveryNote = value.toString();
                            },
                            controller: _deliveryNoteController,
                            maxLines: null,
                            textAlign: TextAlign.start,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Giao trong giờ hành chính...',
                              hintMaxLines: 2,
                              hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: 'Roboto'),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text('Thanh toán',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Roboto', color: AppColors.textBlack)),
                        ),
                        SizedBox(
                          child: CustomRadioButton(
                            data: const ['Tiền mặt', 'Chuyển khoản'],
                            initData: 0,
                            selectedCallBack: (payment){
                              setState(() {
                                viewModel.orderMedicine?.paymentType = viewModel.updatePaymentType(payment);
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 70,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: ElevatedButton(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF3B2313))),
                                onPressed: () {
                                  if(_orderConfirmKey.currentState!.validate()
                                      && viewModel.orderMedicine?.provinceId != null
                                      && viewModel.orderMedicine?.districtId != null){
                                    viewModel.createOrderMedicine(errorCallback: (message){
                                      context.showMessage(message, type: MessageType.error);
                                    },successCallback: (value){
                                      showDefaultDialog(
                                        context,
                                        title: "Thông báo!",
                                        content: "Đặt mua thuốc thành công! Xem lịch sử đặt mua thuốc ngay bây giờ?",
                                        onPressNo: (){
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                        onPressYes: () async {
                                          await Navigator.of(context, rootNavigator: true).popAndPushNamed(PageRoutes.listOrderMedicinePage, arguments: [0, 0]).then((value) {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      );
                                    });
                                  } else{
                                    setState(() {
                                      isProvince = viewModel.isValidate(viewModel.orderMedicine?.provinceId);
                                      isDistrict = viewModel.isValidate(viewModel.orderMedicine?.districtId);
                                      isWard = viewModel.isValidate(viewModel.orderMedicine?.wardId);
                                    });
                                    context.showMessage('Bạn vui lòng điền đầy đủ thông tin', type: MessageType.error);
                                  }
                                },
                                child: const Text('ĐẶT MUA THUỐC', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,color: Colors.white, fontFamily: 'Roboto'))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
