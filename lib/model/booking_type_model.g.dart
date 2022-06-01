// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_type_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension BookingTypeModelCopyWith on BookingTypeModel {
  BookingTypeModel copyWith({
    int? id,
    String? name,
  }) {
    return BookingTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingTypeModel _$BookingTypeModelFromJson(Map json) {
  return BookingTypeModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$BookingTypeModelToJson(BookingTypeModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  return val;
}
