// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension HistoryModelCopyWith on HistoryModel {
  HistoryModel copyWith({
    String? appointmentType,
    String? branchName,
    String? dateStart,
    int? id,
    String? name,
    String? partnerAddress,
    int? partnerId,
    String? phone,
    String? physicianName,
    String? reason,
    String? state,
    String? timeSlotName,
    String? typeName,
  }) {
    return HistoryModel(
      appointmentType: appointmentType ?? this.appointmentType,
      branchName: branchName ?? this.branchName,
      dateStart: dateStart ?? this.dateStart,
      id: id ?? this.id,
      name: name ?? this.name,
      partnerAddress: partnerAddress ?? this.partnerAddress,
      partnerId: partnerId ?? this.partnerId,
      phone: phone ?? this.phone,
      physicianName: physicianName ?? this.physicianName,
      reason: reason ?? this.reason,
      state: state ?? this.state,
      timeSlotName: timeSlotName ?? this.timeSlotName,
      typeName: typeName ?? this.typeName,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map json) {
  return HistoryModel(
    id: json['id'] as int,
    name: json['name'] as String?,
    appointmentType: json['appointment_type'] as String?,
    partnerId: json['partner_id'] as int,
    phone: json['phone'] as String?,
    partnerAddress: json['partner_address'] as String?,
    dateStart: json['date_start'] as String?,
    timeSlotName: json['time_slot_name'] as String?,
    physicianName: json['physician_name'] as String?,
    typeName: json['type_name'] as String?,
    reason: json['reason'] as String?,
    branchName: json['branch_name'] as String?,
    state: json['state'] as String,
  );
}

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('appointment_type', instance.appointmentType);
  val['partner_id'] = instance.partnerId;
  writeNotNull('phone', instance.phone);
  writeNotNull('partner_address', instance.partnerAddress);
  writeNotNull('date_start', instance.dateStart);
  writeNotNull('time_slot_name', instance.timeSlotName);
  writeNotNull('physician_name', instance.physicianName);
  writeNotNull('branch_name', instance.branchName);
  writeNotNull('type_name', instance.typeName);
  writeNotNull('reason', instance.reason);
  val['state'] = instance.state;
  return val;
}
