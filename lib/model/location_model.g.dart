// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension LocationModelCopyWith on LocationModel {
  LocationModel copyWith({
    int? id,
    String? name,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map json) {
  return LocationModel(
    id: json['id'] as int,
    name: json['name'] as String,
  )..isSelected = json['isSelected'] as bool?;
}

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('isSelected', instance.isSelected);
  return val;
}
