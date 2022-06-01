// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension BookingModelCopyWith on BookingModel {
  BookingModel copyWith({
    String? appointmentDate,
    String? birthday,
    int? branchId,
    int? doctorId,
    String? phone,
    String? reason,
    int? timeSlot,
    int? typeId,
    String? username,
  }) {
    return BookingModel(
      appointmentDate: appointmentDate ?? this.appointmentDate,
      birthday: birthday ?? this.birthday,
      branchId: branchId ?? this.branchId,
      doctorId: doctorId ?? this.doctorId,
      phone: phone ?? this.phone,
      reason: reason ?? this.reason,
      timeSlot: timeSlot ?? this.timeSlot,
      typeId: typeId ?? this.typeId,
      username: username ?? this.username,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map json) {
  return BookingModel(
    username: json['username'] as String?,
    phone: json['phone'] as String?,
    birthday: json['birthday'] as String?,
    typeId: json['type_id'] as int?,
    branchId: json['branch_id'] as int?,
    doctorId: json['doctor_id'] as int?,
    appointmentDate: json['appointment_date'] as String?,
    timeSlot: json['time_slot'] as int?,
    reason: json['reason'] as String?,
  );
}

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('username', instance.username);
  writeNotNull('phone', instance.phone);
  writeNotNull('birthday', instance.birthday);
  writeNotNull('type_id', instance.typeId);
  writeNotNull('branch_id', instance.branchId);
  writeNotNull('doctor_id', instance.doctorId);
  writeNotNull('appointment_date', instance.appointmentDate);
  writeNotNull('time_slot', instance.timeSlot);
  writeNotNull('reason', instance.reason);
  return val;
}
