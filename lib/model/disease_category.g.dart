// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disease_category.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension DiseaseCategoryCopyWith on DiseaseCategory {
  DiseaseCategory copyWith({
    int? id,
    String? image,
    int? level,
    String? multiIndex,
    String? name,
    List<String>? parentId,
    int? sequence,
  }) {
    return DiseaseCategory(
      id: id ?? this.id,
      image: image ?? this.image,
      level: level ?? this.level,
      multiIndex: multiIndex ?? this.multiIndex,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      sequence: sequence ?? this.sequence,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiseaseCategory _$DiseaseCategoryFromJson(Map json) {
  return DiseaseCategory(
    id: json['id'] as int?,
    name: json['name'] as String?,
    sequence: json['sequence'] as int?,
    multiIndex: json['multiIndex'] as String?,
    image: json['image'] as String?,
    parentId:
        (json['parentId'] as List<dynamic>?)?.map((e) => e as String).toList(),
    level: json['level'] as int?,
  );
}

Map<String, dynamic> _$DiseaseCategoryToJson(DiseaseCategory instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('sequence', instance.sequence);
  writeNotNull('multiIndex', instance.multiIndex);
  writeNotNull('image', instance.image);
  writeNotNull('parentId', instance.parentId);
  writeNotNull('level', instance.level);
  return val;
}
