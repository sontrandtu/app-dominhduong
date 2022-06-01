import 'package:dominhduong/api/api_response.dart';
import 'package:dominhduong/api/response_model/list_response.dart';
import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/base/loadmore_mixin.dart';
import 'package:dominhduong/model/history_model.dart';
import 'package:dominhduong/model/timeslot_model.dart';
import 'package:dominhduong/repository/booking_repository.dart';

class ListHistoryViewModel extends BaseViewModel with LoadMoreMixin<HistoryModel> {
  final BookingRepository repo;
  List<TimeSlotModel> listTimeSlot = [];

  ListHistoryViewModel({required this.repo}) : super(repo){
    refreshData(needShowLoading: true);
  }

  @override
  Future<ApiResponse<ListResponse<List<HistoryModel>>>> getData() {
    return repo.getListHistory(pagingRequest.page!);
  }

  @override
  void notifyData() {
    notifyListeners();
  }

  @override
  set notifyLoading(bool value) {
    setLoading = value;
  }
}
