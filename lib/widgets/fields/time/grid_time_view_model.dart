

import 'dart:ui';

import 'package:dominhduong/base/base_view_model.dart';
import 'package:dominhduong/model/timeslot_model.dart';
import 'package:dominhduong/repository/booking_repository.dart';
import 'package:dominhduong/repository/repository.dart';


class GridTimeViewModel extends BaseViewModel {

  final BookingRepository timeRepository;

  List<TimeSlotModel> timeSlots = [];

  String? timeSlotId;

  GridTimeViewModel( {required this.timeRepository}) : super(timeRepository) {
    loadTimeSlots();
  }

  loadTimeSlots({VoidCallback? onLoadedCallback, ErrorCallback? errorCallback}) async {
    setLoading = true;
    final response = await timeRepository.getTimeSlots();
    if (response.isOk) {
      timeSlots.addAll(response.data!.items ?? []);
    }
    else {
      errorCallback?.call(response.message);
    }
    onLoadedCallback?.call();
    setLoading = false;
  }
}