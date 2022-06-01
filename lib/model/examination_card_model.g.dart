// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examination_card_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ExaminationCardModelCopyWith on ExaminationCardModel {
  ExaminationCardModel copyWith({
    String? dateStart,
    String? detail,
    int? id,
    String? name,
    int? orderCount,
    int? physicianId,
    String? physicianName,
  }) {
    return ExaminationCardModel(
      dateStart: dateStart ?? this.dateStart,
      detail: detail ?? this.detail,
      id: id ?? this.id,
      name: name ?? this.name,
      orderCount: orderCount ?? this.orderCount,
      physicianId: physicianId ?? this.physicianId,
      physicianName: physicianName ?? this.physicianName,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExaminationCardModel _$ExaminationCardModelFromJson(Map json) {
  return ExaminationCardModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    detail: json['detail'] as String?,
    dateStart: json['date_start'] as String?,
    physicianId: json['physician_id'] as int?,
    physicianName: json['physician_name'] as String?,
    orderCount: json['order_count'] as int?,
  );
}

Map<String, dynamic> _$ExaminationCardModelToJson(
    ExaminationCardModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('detail', instance.detail);
  writeNotNull('date_start', instance.dateStart);
  writeNotNull('physician_id', instance.physicianId);
  writeNotNull('physician_name', instance.physicianName);
  writeNotNull('order_count', instance.orderCount);
  return val;
}
