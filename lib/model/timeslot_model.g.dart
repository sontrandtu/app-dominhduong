// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslot_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension TimeSlotModelCopyWith on TimeSlotModel {
  TimeSlotModel copyWith({
    int? id,
    String? name,
    String? timeEnd,
    String? timeStart,
  }) {
    return TimeSlotModel(
      id: id ?? this.id,
      name: name ?? this.name,
      timeEnd: timeEnd ?? this.timeEnd,
      timeStart: timeStart ?? this.timeStart,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlotModel _$TimeSlotModelFromJson(Map json) {
  return TimeSlotModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    timeStart: json['time_start'] as String?,
    timeEnd: json['time_end'] as String?,
  );
}

Map<String, dynamic> _$TimeSlotModelToJson(TimeSlotModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('time_start', instance.timeStart);
  writeNotNull('time_end', instance.timeEnd);
  return val;
}
