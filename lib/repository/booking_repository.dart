import 'package:dominhduong/api/api_config.dart';
import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/model/booking_model.dart';
import 'package:dominhduong/model/history_model.dart';
import 'package:dominhduong/model/timeslot_model.dart';
import 'package:dominhduong/repository/repository.dart';

class BookingRepository extends Repository {

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
    int? doctorId,
    required int timeSlot,
    required String username,
    required String phone,
    required String birthday,
    required String appointmentDate,
    required String reason,
  }) async {
    return await apiClient!.bookingTreatment( doctor: doctorId, timeSlot: timeSlot, username: username, phone: phone, birthday: birthday, appointmentDate: appointmentDate, reason: reason).wrap();
  }

  Future<ApiResponse<ListResponse<List<HistoryModel>>>> getListHistory(int page, {int limit = ApiConfig.pageSize}) async {
    return await apiClient!.getListHistory(page: page, limit: limit).wrap();
  }
}
