import 'package:dominhduong/screens/booking/booking_view_model.dart';
import 'package:dominhduong/theme/colors.dart';
import 'package:dominhduong/utils/dialog_utils.dart';
import 'package:dominhduong/utils/extensions.dart';
import 'package:dominhduong/widgets/appbar/appbar_comp.dart';
import 'package:dominhduong/widgets/cover_loading.dart';
import 'package:dominhduong/widgets/fields/dropdown/custom_dropdown_button.dart';
import 'package:dominhduong/widgets/fields/time/grid_date.dart';
import 'package:dominhduong/widgets/fields/time/grid_time.dart';
import 'package:dominhduong/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../widgets/appbar/appbar_comp.dart';
export 'package:dominhduong/utils/extensions/string_extension.dart';


import '../history/list_history_view_model.dart';
class BookingPage extends StatefulWidget {
  final String type;
  const BookingPage({Key? key, required this.type}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isSelectedBranch = false;
  bool isSelectedTime = false;
  bool isSelectedType = false;
  bool isReason = false;
  final TextEditingController _reason = TextEditingController();
  final GlobalKey<FormState> _bookingFormKey = GlobalKey<FormState>();
  final ScrollController controller = ScrollController();
  int daySelected = DateTime.now().day;
  int monthSelected = DateTime.now().month;
  int yearSelected = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BookingViewModel>();
    return Scaffold(
      appBar: PageAppBarComp(title: 'Đặt lịch'.toUpperCase(), canPop: widget.type == 'main' ? true : false),
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SmartRefresher(
            controller: _refreshController,
            enablePullUp: true,
            onRefresh: () {
              viewModel.loadData(
                  onLoadedCallback: () {
                    _refreshController.refreshCompleted();
                  },
                  errorCallback: (message) {
                    context.showMessage(message, type: MessageType.error);
                  }
              );
            },
            child: CoverLoading(
              showLoading: viewModel.isLoading,
              isStack: true,
              child: SingleChildScrollView(
                controller: controller,
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                child: Container(
                    margin: const EdgeInsets.only(top: 26, bottom: 25, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: _bookingFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 0, right: 0, bottom: 5, top: 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Thông tin người đặt lịch', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Roboto', color: AppColors.textBlack)),
                                    const SizedBox(height: 10),
                                    RichText(
                                      text: const TextSpan(
                                        style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
                                        children: [
                                          TextSpan(text: '(', style: TextStyle(color: Colors.black)),
                                          TextSpan(text: '* ', style: TextStyle(color: Colors.red)),
                                          TextSpan(text: 'Bắt buộc)', style: TextStyle(color: Colors.black)),
                                        ],
                                      ),
                                    ),
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
                                            viewModel.bookingModel.username = value!.trim();
                                          },
                                          value: viewModel.bookingModel.username,
                                        ),
                                        const SizedBox(height: 24),
                                        CustomInputField(
                                          keyboardType: TextInputType.number,
                                          formatters: [FilteringTextInputFormatter.digitsOnly],
                                          maxLength: 12,
                                          labelWidget: RichText(
                                            text: TextSpan(
                                              children: [
                                                const TextSpan(text: '* ', style: TextStyle(color: Colors.red,fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: 14)),
                                                TextSpan(text: 'Số điên thoại',style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: 'Roboto', fontSize: 14),),
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
                                            viewModel.bookingModel.phone = value!.trim();
                                          },
                                          value: viewModel.bookingModel.phone,
                                        ),
                                        const SizedBox(height: 24),
                                        GestureDetector(
                                          onTap: () {
                                            context.hideKeyboard();
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(1900, 1, 1),
                                                maxTime: DateTime.now(),
                                                onChanged: (date) {}, onConfirm: (DateTime date) {
                                              viewModel.updateBirthday(date.dateTimeToDDMMYYYY);
                                            },
                                                currentTime: (viewModel.bookingModel.birthday == null || viewModel.bookingModel.birthday!.isEmpty) ? DateTime.now() : DateFormat('DD/MM/yyyy').parse(viewModel.bookingModel.birthday!),
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
                                              value: viewModel.bookingModel.birthday,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text('Địa điểm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: AppColors.backgroundBlack)),
                                  // viewModel.branches.isNotEmpty ? CustomDropdownButton(
                                  //   isRefresh: viewModel.isRefresh,
                                  //   placeholderText: viewModel.holderBranchText,
                                  //   icons: Icons.place_outlined,
                                  //   data: viewModel.branches,
                                  //   isValidate: isSelectedBranch,
                                  //   type: 1,
                                  //   onSelectedCallback: (companyId) {
                                  //     viewModel.bookingModel.branchId = companyId;
                                  //     viewModel.loadDoctorsByBranch();
                                  //     setState(() {
                                  //       isSelectedBranch = viewModel.isValidate(viewModel.bookingModel.branchId);
                                  //     });
                                  //   },
                                  // ) : CustomDropdownButtonDefault(
                                  //   type: 1,
                                  //   readOnly: true,ab
                                  //   placeholderText: viewModel.holderBranchText,
                                  //   icons: Icons.place_outlined,
                                  // ),
                                  // Visibility(
                                  //     visible: isSelectedBranch,
                                  //     child: const Text('Vui lòng chọn chi nhánh', style: TextStyle(color: Colors.red, fontFamily: 'Roboto', fontSize: 12))
                                  // ),
                                  // viewModel.doctors.isNotEmpty ?
                                  CustomDropdownButton(
                                    isRefresh: viewModel.isRefresh,
                                    readOnly: false,
                                    placeholderText: viewModel.holderDoctorText,
                                    icons: Icons.perm_contact_calendar_outlined,
                                    data: viewModel.doctors,
                                    //isValidate: isSelectedDoctor,
                                    type: 1,
                                    onSelectedCallback: (doctorId) {
                                      viewModel.bookingModel.doctorId = doctorId;
                                    },
                                  ),
                                  //     : CustomDropdownButtonDefault(
                                  //   type: 1,
                                  //   readOnly: true,
                                  //   //isValidate: isSelectedDoctor,
                                  //   placeholderText: viewModel.holderDoctorText,
                                  //   icons: Icons.perm_contact_calendar_outlined,
                                  // ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text('Lịch hẹn', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontFamily: 'Roboto', color: AppColors.iconDefaultColor))
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: RichText(
                                        text: const TextSpan(
                                            style: TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.black),
                                            children: [
                                              TextSpan(text: 'Chọn ngày khám'),
                                              TextSpan(text: ' * ', style: TextStyle(color: Colors.red)),
                                            ]
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: double.infinity,
                                    child: GridDate(
                                      isRefresh: viewModel.isRefresh,
                                      onDateSelectedCallback: (day) {
                                        viewModel.bookingModel.appointmentDate = day;
                                        WidgetsBinding.instance?.addPostFrameCallback((_) {
                                          setState(() {
                                            daySelected = int.parse(viewModel.bookingModel.appointmentDate!.substring(0,2));
                                            monthSelected = int.parse(viewModel.bookingModel.appointmentDate!.substring(3,5));
                                            yearSelected = int.parse(viewModel.bookingModel.appointmentDate!.substring(6,10));
                                            viewModel.bookingModel.timeSlot = null;
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: RichText(
                                          text: const TextSpan(
                                              style: TextStyle(fontSize: 14, fontFamily: 'Roboto', color: Colors.black),
                                              children: [
                                                TextSpan(text: 'Thời gian'),
                                                TextSpan(text: ' * ', style: TextStyle(color: Colors.red)),
                                              ]
                                          )
                                      )
                                  ),
                                  GridTime(
                                    isRefresh: viewModel.isRefresh,
                                    selectedIndex: viewModel.selectedIndex,
                                    daySelected: daySelected,
                                    monthSelected: monthSelected,
                                    yearSelected: yearSelected,
                                    timeSlots: viewModel.timeSlots,
                                    onTimeSlotSelectedCallback: (timeSlotID) {
                                      viewModel.bookingModel.timeSlot = timeSlotID;
                                      setState(() {
                                        isSelectedTime = viewModel.isValidate(viewModel.bookingModel.timeSlot);
                                      });
                                    },
                                  ),
                                  Visibility(
                                    visible: isSelectedTime,
                                    child: const Text('Vui lòng chọn thời gian khám phù hợp', style: TextStyle(color: Colors.red, fontFamily: 'Roboto', fontSize: 12)),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomDropdownButton(
                                    isRefresh: viewModel.isRefresh,
                                    placeholderText: viewModel.holderTypeText,
                                    icons: Icons.sick_outlined,
                                    data: viewModel.listBookingType,
                                    isValidate: isSelectedType,
                                    type: 1,
                                    onSelectedCallback: (typeId) {
                                      viewModel.bookingModel.typeId = typeId;
                                      setState(() {
                                        isSelectedType = viewModel.isValidate(viewModel.bookingModel.typeId);
                                      });
                                    },
                                  ),
                                  Visibility(
                                    visible: isSelectedType,
                                    child: const Text('Vui lòng chọn đầu bệnh', style: TextStyle(color: Colors.red, fontFamily: 'Roboto', fontSize: 12)),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 15, bottom: 10),
                                      child: RichText(
                                          text: const TextSpan(
                                              style: TextStyle(fontSize: 16, fontFamily: 'Roboto', fontWeight: FontWeight.w700, fontStyle: FontStyle.normal),
                                              children: [
                                                TextSpan(text: 'Lý do khám', style: TextStyle(color: Colors.black)),
                                                TextSpan(text: ' * ', style: TextStyle(color: Colors.red)),
                                              ]
                                          )
                                      )
                                  ),
                                  TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    onChanged: (String? value) {
                                      viewModel.bookingModel.reason = value!.trim();
                                    },
                                    validator: (String? message){
                                      if(message == null || message.isEmpty){
                                        return "Vui lòng nhập lý do khám";
                                      }
                                      return null;
                                    },
                                    controller: _reason,
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
                                      hintText: 'Mô tả các triệu chứng bạn đang gặp phải hoặc vấn đề cần tư vấn. VD: Ho, đau họng, khó thở..',
                                      hintMaxLines: 2,
                                      hintStyle: const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, fontSize: 12),
                                    ),
                                    style: const TextStyle(color: Colors.black, fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 14),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 70,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: ElevatedButton(
                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xFF3B2313))),
                                            onPressed: () {
                                              if (_bookingFormKey.currentState!.validate()
                                                  // && viewModel.bookingModel.branchId != null
                                                  && viewModel.bookingModel.doctorId != null
                                                  && viewModel.bookingModel.typeId != null
                                                  && viewModel.bookingModel.timeSlot != 0
                                                  && viewModel.bookingModel.timeSlot != null
                                              ) {
                                                viewModel.bookingPostData(successCallback: (value) {
                                                  setState((){
                                                    isSelectedType = false;
                                                    isSelectedTime = false;
                                                    isSelectedBranch = false;
                                                    _reason.clear();
                                                    controller.jumpTo(0.0);
                                                  });
                                                  showAlertSuccessBooking(context,() {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(context).pop();
                                                  },);
                                                  context.hideKeyboard();
                                                  // Reset data trang đặt lịch
                                                  Provider.of<ListHistoryViewModel>(context, listen: false).refreshData(needShowLoading: false);
                                                }, errorCallback: (message) {
                                                  context.showMessage(message, type: MessageType.error);
                                                });
                                              } else {
                                                setState(() {
                                                  context.showMessage('Vui lòng điền đầy đủ thông tin', type: MessageType.error);
                                                  isSelectedBranch = viewModel.isValidate(viewModel.bookingModel.branchId);
                                                  isSelectedTime = viewModel.isValidate(viewModel.bookingModel.timeSlot);
                                                  isSelectedType = viewModel.isValidate(viewModel.bookingModel.typeId);
                                                });
                                              }
                                            },
                                            child: const Text('ĐẶT LỊCH', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal,color: Colors.white, fontFamily: 'Roboto'))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}