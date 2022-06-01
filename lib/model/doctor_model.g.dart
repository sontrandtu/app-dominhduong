// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension DoctorModelCopyWith on DoctorModel {
  DoctorModel copyWith({
    int? branchId,
    String? content,
    String? description,
    int? id,
    String? image,
    String? name,
    int? physicianId,
    String? position,
    int? sequence,
    String? writeDate,
  }) {
    return DoctorModel(
      branchId: branchId ?? this.branchId,
      content: content ?? this.content,
      description: description ?? this.description,
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      physicianId: physicianId ?? this.physicianId,
      position: position ?? this.position,
      sequence: sequence ?? this.sequence,
      writeDate: writeDate ?? this.writeDate,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map json) {
  return DoctorModel(
    id: json['id'] as int?,
    sequence: json['sequence'] as int?,
    name: json['name'] as String?,
    position: json['position'] as String?,
    image: json['image'] as String?,
    description: json['description'] as String?,
    content: json['content'] as String?,
    branchId: json['branch_id'] as int?,
    physicianId: json['physician_id'] as int?,
    writeDate: json['write_date'] as String?,
  )..isSelected = json['isSelected'] as bool?;
}

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('sequence', instance.sequence);
  writeNotNull('name', instance.name);
  writeNotNull('position', instance.position);
  writeNotNull('image', instance.image);
  writeNotNull('description', instance.description);
  writeNotNull('content', instance.content);
  writeNotNull('branch_id', instance.branchId);
  writeNotNull('physician_id', instance.physicianId);
  writeNotNull('write_date', instance.writeDate);
  writeNotNull('isSelected', instance.isSelected);
  return val;
}
