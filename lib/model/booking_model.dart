import 'dart:core';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class BookingModel {
  String? username;
  String? phone;
  String? birthday;
  @JsonKey(name: 'type_id')
  int? typeId;
  @JsonKey(name: 'branch_id')
  int? branchId;
  @JsonKey(name: 'doctor_id')
  int? doctorId;
  @JsonKey(name: 'appointment_date')
  String? appointmentDate;
  @JsonKey(name: 'time_slot')
  int? timeSlot;
  String? reason;

  BookingModel({
    this.username,
    this.phone,
    this.birthday,
    this.typeId,
    this.branchId,
    this.doctorId,
    this.appointmentDate,
    this.timeSlot,
    this.reason,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}