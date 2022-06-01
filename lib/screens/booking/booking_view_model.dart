import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/model/booking_model.dart';
import 'package:dominhduong/model/booking_type_model.dart';
import 'package:dominhduong/model/branch_model.dart';
import 'package:dominhduong/model/doctor_model.dart';
import 'package:dominhduong/model/timeslot_model.dart';
import 'package:dominhduong/model/user/user_info_model.dart';
import 'package:dominhduong/repository/booking_repository.dart';
import 'package:dominhduong/repository/doctor_repository.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import '../../preference/preference.dart';
import '../../repository/user_repository.dart';
import '../../utils/toast_utils.dart';

class BookingViewModel extends BaseViewModel {
  final BookingRepository repo;
  final DoctorRepository doctorRepo;
  final UserRepository userRepo;
  final int branchId;
  final int doctorId;

  List<BranchModel> branches = [];
  List<DoctorModel> doctors = [];
  List<TimeSlotModel> timeSlots = [];
  List<BookingTypeModel> listBookingType = [];

  BookingModel bookingModel = BookingModel();
  UserInfoModel userInfoModel = UserInfoModel();
  String holderBranchText = 'Chọn chi nhánh';
  String holderDoctorText = "Chọn bác sĩ";
  String holderTypeText = 'Bạn cần đặt lịch?';
  int selectedIndex = -1;
  bool isRefresh = true;

  BookingViewModel({required this.repo, required this.doctorRepo, required this.userRepo, this.branchId = 0, this.doctorId = 0}) : super(repo) {
    loadData();
  }

  bool isValidate(dynamic input){
    if(input == null){

      return true;
    }
    return false;
  }

  updateBirthday(String date){
    bookingModel.birthday = date;
    notifyListeners();
  }

  loadData({VoidCallback? onLoadedCallback, ErrorCallback? errorCallback}) async {
    setLoading = true;
    final response = await Future.wait([repo.getBranches(), repo.getListBookingType(), repo.getTimeSlots()]);

    if (response[0].isOk) {
      branches = (response[0] as ApiResponse<ListResponse<List<BranchModel>>>).data?.items ?? [];
    } else {
      errorCallback?.call(response[0].message);
    }

    if (response[1].isOk) {
      listBookingType = (response[1] as ApiResponse<ListResponse<List<BookingTypeModel>>>).data?.items ?? [];
    } else {
      errorCallback?.call(response[1].message);
    }

    if (response[2].isOk) {
      timeSlots = (response[2] as ApiResponse<ListResponse<List<TimeSlotModel>>>).data?.items ?? [];
    }else {
      errorCallback?.call(response[2].message);
    }

    await loadUserInfo();

    if(branchId != 0 && doctorId != 0) {
      bookingModel.branchId = branchId;
      bookingModel.doctorId = doctorId;
      int bIdx = branches.indexWhere((element) => element.id == branchId);
      if(bIdx > -1) branches[bIdx].isSelected = true;
      await loadDoctorsByBranch();
      int dIdx = doctors.indexWhere((element) => element.physicianId == doctorId);
      if(dIdx > -1) doctors[dIdx].isSelected = true;
    }

    onLoadedCallback?.call();
    setLoading = false;
  }

  loadUserInfo({SuccessCallback? successCallback, ErrorCallback? errorCallback}) async {
    await userRepo.getUserInfo().then((response) {
      if (response.isOk) {
        userInfoModel = response.data!;
        setBookingUser(info: userInfoModel);
      } else {
        errorCallback?.call(response.message);
      }
    });
  }

  setBookingUser({required UserInfoModel info}) {
    bookingModel.username = info.name ?? '';
    bookingModel.phone = info.phone ?? '';
    bookingModel.birthday = info.birthday ?? '';

    notifyListeners();
  }

  loadDoctorsByBranch() async{
    final response = await doctorRepo.getDoctorsByBranch(bookingModel.branchId);
    if(response.isOk){
      doctors.clear();
      bookingModel.doctorId = -1;
      doctors.addAll(response.data?.items ?? []);
    }
    notifyListeners();
  }

  bookingPostData({ErrorCallback? errorCallback, SuccessCallback? successCallback}) async {
    setLoading = true;

    final response = await repo.postBooking(
      username: bookingModel.username ?? '',
      phone: bookingModel.phone ?? '',
      birthday: bookingModel.birthday ?? '',
      typeId: bookingModel.typeId!,
      branchId: bookingModel.branchId!,
      appointmentDate: bookingModel.appointmentDate!,
      timeSlot: bookingModel.timeSlot!,
      reason: bookingModel.reason!,
      doctorId: bookingModel.doctorId == -1 ? null : bookingModel.doctorId!,
    ).catchError((onError) {
      setLoading = false;
      showMessage('Có lỗi hệ thống xảy ra!');
    });
    if (response.isOk) {
      successCallback?.call('Đặt lịch thành công !');
      clearData();
    } else {
      errorCallback?.call(response.message);
    }

    setLoading = false;
  }

  clearData(){
    bookingModel.username = userInfoModel.name;
    bookingModel.phone = userInfoModel.phone;
    bookingModel.birthday = userInfoModel.birthday;
    bookingModel.appointmentDate = '';
    bookingModel.reason = '';
    bookingModel.branchId = null;
    bookingModel.typeId = null;
    bookingModel.doctorId = null;
    bookingModel.timeSlot = null;
    doctors.clear();
    holderBranchText = 'Chọn chi nhánh';
    holderDoctorText = "Chọn bác sĩ";
    holderTypeText = 'Bạn cần đặt lịch?';
    selectedIndex = -1;
    isRefresh = !isRefresh;
    notifyListeners();
  }
}
