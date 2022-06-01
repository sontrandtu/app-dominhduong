import 'dart:io';
import 'package:dominhduong/utils/extensions.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/fields/grid_course_of_treatment.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../page_routes.dart';
import '../../../theme/colors.dart';
import '../../../utils/dialog_utils.dart';
import '../../../widgets/input_field.dart';
import '../../widgets/fields/custom_radio_button.dart';
import 'categories_dropdown_button.dart';
import 'order_medicine_view_model.dart';
class OrderMedicinePage extends StatefulWidget {
  const OrderMedicinePage({Key? key}) : super(key: key);

  @override
  _OrderMedicinePageState createState() => _OrderMedicinePageState();
}

class _OrderMedicinePageState extends State<OrderMedicinePage> {

  final GlobalKey<FormState> _orderKey = GlobalKey<FormState>();
  final TextEditingController _noteController = TextEditingController();
  int selectedIndex = 0;
  bool isVisible = false;
  bool isVisibleImage = false;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OrderMedicineViewModel>();
    return GestureDetector(
      onTap: (){
        context.hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: PageAppBarComp(title: "ĐẶT THUỐC"),
        body: SafeArea(
          child: CoverLoading(
            showLoading: viewModel.isLoading,
            isStack: true,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.only(top: 26, bottom: 25, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _orderKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 0, right: 0, bottom: 5, top: 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Thông tin người đặt', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Roboto', color: AppColors.textBlack)),
                                const SizedBox(height: 10),
                                RichText(
                                    text: const TextSpan(
                                        style: TextStyle(fontSize: 12, fontFamily: 'Roboto',),
                                        children: [
                                          TextSpan(text: '(', style: TextStyle(color: Colors.black)),
                                          TextSpan(text: '* ', style: TextStyle(color: Colors.red)),
                                          TextSpan(text: 'Bắt buộc)', style: TextStyle(color: Colors.black)
                                          ),
                                        ]
                                    )
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 20, left: 0),
                                child: Column(
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
                                        viewModel.orderMedicineModel.receiverName = value!.trim();
                                      },
                                      value: viewModel.orderMedicineModel.receiverName,
                                    ),
                                    Padding(
                                      padding:     const EdgeInsets.symmetric(vertical: 24),
                                      child: CustomInputField(
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
                                        prefixIcon: const Icon(Icons.phone_outlined, color: Colors.black54),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Vui lòng nhập số điện thoại';
                                          } else if (value.length < 10) {
                                            return 'Số điện thoại phi lớn hơn 10 số';
                                          }
                                          return null;
                                        },
                                        onChanged: (String? value) {
                                          viewModel.orderMedicineModel.receiverPhone = value!.trim();
                                        },
                                        value:  viewModel.orderMedicineModel.receiverPhone,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.hideKeyboard();
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(1900, 1, 1),
                                            maxTime: DateTime.now(),
                                            onChanged: (date) {}, onConfirm: (DateTime date) {
                                              viewModel.updateBirthDay = date.dateTimeToDDMMYYYY;
                                            },
                                            currentTime: (viewModel.birthday.isEmpty)
                                                ? DateTime.now()
                                                : DateFormat('DD/MM/yyyy')
                                                .parse(viewModel.birthday),
                                            locale: LocaleType.vi);
                                      },
                                      child: AbsorbPointer(
                                        child: CustomInputField(
                                          keyboardType: TextInputType.text,
                                          labelWidget: RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                                TextSpan(text: 'Ngày sinh',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
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
                                          value: viewModel.birthday,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Text('Bạn muốn đặt thuốc gì?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: AppColors.backgroundBlack)),
                              CategoriesDropdownButton(
                                placeholderText: 'Bạn muốn đặt thuốc gì?',
                                icons: Icons.sick_outlined,
                                data: viewModel.listCategory,
                                type: 1,
                                isValidate: isVisible,
                                onSelectedCallback: (id) {
                                  setState(() {
                                    viewModel.orderMedicineModel.categoryId = id;
                                    isVisible = viewModel.isValidate(viewModel.orderMedicineModel.categoryId);
                                  });
                                },
                              ),
                              Visibility(
                                  visible: isVisible,
                                  child: const Text('Vui lòng chọn đầu bệnh', style: TextStyle(color: Colors.red, fontFamily: 'Roboto', fontSize: 14))
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text('Số liệu trình muốn đặt', style: TextStyle(fontStyle: FontStyle.normal, fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),),
                              ),
                              SizedBox(
                                height: 50,
                                child: GridCourseOfTreatment(
                                  maxCourse: 5,
                                  onAmountSelectedCallback: (amount){
                                    viewModel.orderMedicineModel.quantity = amount;
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 25, bottom: 15),
                                child: Text('Bạn đã có đơn thuốc chưa?', style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto'),),
                              ),
                              SizedBox(
                                child: CustomRadioButton(
                                  data: const ['Đã có đơn thuốc', 'Chưa có đơn thuốc'],
                                  initData: 1,
                                  selectedCallBack: (prescription){
                                    setState(() {
                                      viewModel.orderMedicineModel.isHavePrescription = viewModel.updatePrescription(prescription);
                                    });
                                  },
                                ),
                              ),
                              (viewModel.orderMedicineModel.isHavePrescription!) ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Text('Bạn vui lòng tải hình ảnh đơn thuốc hoặc chụp lại đơn thuốc',
                                      style: TextStyle(fontSize: 12, fontFamily: 'Roboto', fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  DottedBorder(
                                    color: Colors.black.withOpacity(0.36),
                                    strokeWidth: 1,
                                    radius: const Radius.circular(8),
                                    child: SizedBox(
                                      height: 144,
                                      child: Stack(
                                        children: [
                                          (isVisibleImage) ? Center(
                                            child: Image.file(imageFile!,fit:  BoxFit.fill),
                                          ) : const SizedBox(),
                                          (!isVisibleImage) ? Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.file_upload_outlined),
                                                const SizedBox(height: 15.75),
                                                GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheetImage(
                                                        context: context,
                                                        imageCallBack: (image) {
                                                          if(image != null){
                                                            setState(() {
                                                              imageFile = File(image);
                                                              isVisibleImage = true;
                                                            });
                                                          }
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 32,
                                                      width: 108,
                                                      decoration: BoxDecoration(
                                                          color: AppColors.primaryColor,
                                                          borderRadius: BorderRadius.circular(8)
                                                      ),
                                                      child: const Center(child: Text('Chọn/Chụp ảnh', style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700, fontSize: 12),)),
                                                    )
                                                ),
                                                const SizedBox(height: 5), // chọn chụp ảnh
                                                const Text('Tối đa 10MB', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),)
                                              ],
                                            ),
                                          ) : Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isVisibleImage = !isVisibleImage;
                                                  imageFile = null;
                                                });
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.withOpacity(0.5),
                                                    shape: BoxShape.circle
                                                ),
                                                child: const Icon(Icons.clear, size: 18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ) : const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Nhà thuốc Đỗ Minh Đường sẽ gọi điện tư vấn và tạo đơn giúp bạn',
                                  style: TextStyle(fontFamily: 'Roboto', fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                              children: [
                                TextSpan(text: 'Ghi chú ', style: TextStyle(color: Colors.black)),
                                TextSpan(text: '* ', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              viewModel.orderMedicineModel.note = value.toString().trim();
                            },
                            validator: (String? message){
                              if(message!.isEmpty){
                                return "Vui lòng nhập ghi chú";
                              }
                              return null;
                            },
                            controller: _noteController,
                            maxLines: 5,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor), borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)), borderRadius: BorderRadius.circular(8)),
                              errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(8)),
                              focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(8)),
                              disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)), borderRadius: BorderRadius.circular(8)),
                              border: InputBorder.none,
                              hintText: 'Bạn lấy thuốc lần đầu hay lấy thêm liệu trình? Tình trạng bệnh hiện tại của bạn ra sao?',
                              hintMaxLines: 2,
                              hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, fontFamily: 'Roboto'),
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
                                    context.hideKeyboard();
                                    if(_orderKey.currentState!.validate() && viewModel.orderMedicineModel.categoryId != null){
                                      if(viewModel.orderMedicineModel.isHavePrescription! && imageFile == null){
                                        context.showMessage("Bạn vui lòng thêm hình ảnh đơn thuốc!", type: MessageType.error);
                                      } else{
                                        Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.orderMedicineConfirmPage, arguments: [viewModel.orderMedicineModel, imageFile]);
                                      }
                                    }else{
                                      setState(() => isVisible = viewModel.isValidate(viewModel.orderMedicineModel.categoryId));
                                      context.showMessage("Bạn vui lòng điền đầy đủ thông tin!", type: MessageType.error);
                                    }
                                  },
                                  child: const Text('TIẾP TỤC', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,color: Colors.white, fontFamily: 'Roboto'))),
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
      ),
    );
  }
}
