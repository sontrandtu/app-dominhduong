import 'package:dominhduong/api/api_config.dart';
import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/model/booking_model.dart';
import 'package:dominhduong/model/booking_type_model.dart';
import 'package:dominhduong/model/branch_model.dart';
import 'package:dominhduong/model/company_model.dart';
import 'package:dominhduong/model/history_model.dart';
import 'package:dominhduong/model/timeslot_model.dart';
import 'package:dominhduong/repository/repository.dart';

class BookingRepository extends Repository {
  Future<ApiResponse<ListResponse<List<CompanyModel>>>> getCompanies() async {
    return await apiClient!.getCompanies().wrap();
  }

  Future<ApiResponse<ListResponse<List<BranchModel>>>> getBranches() async {
    return await apiClient!.getBranches(children: 0).wrap();
  }

  Future<ApiResponse<ListResponse<List<BookingTypeModel>>>> getListBookingType() async {
    return await apiClient!.getListBookingType().wrap();
  }

  Future<ApiResponse<ListResponse<List<TimeSlotModel>>>> getTimeSlots() async {
    return await apiClient!.getTimeSlots().wrap();
  }

  Future<ApiResponse<ListResponse<List<TimeSlotModel>>>> booking({
    required String username,
    required String phone,
  }) async {
    return await apiClient!.getTimeSlots().wrap();
  }

  Future<ApiResponse<BookingModel>> postBooking({
    required int branchId,
    int? doctorId,
    required int timeSlot,
    required int typeId,
    required String username,
    required String phone,
    required String birthday,
    required String appointmentDate,
    required String reason,
  }) async {
    return await apiClient!.bookingTreatment(branchId: branchId, doctor: doctorId, timeSlot: timeSlot, typeId: typeId, username: username, phone: phone, birthday: birthday, appointmentDate: appointmentDate, reason: reason).wrap();
  }

  Future<ApiResponse<ListResponse<List<HistoryModel>>>> getListHistory(int page, {int limit = ApiConfig.pageSize}) async {
    return await apiClient!.getListHistory(page: page, limit: limit).wrap();
  }
}
