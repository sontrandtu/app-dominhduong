// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension CategoryModelCopyWith on CategoryModel {
  CategoryModel copyWith({
    int? id,
    String? image,
    bool? isSelected,
    int? level,
    String? multiIndex,
    String? name,
    int? numberChildren,
    int? parentId,
    int? sequence,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      image: image ?? this.image,
      isSelected: isSelected ?? this.isSelected,
      level: level ?? this.level,
      multiIndex: multiIndex ?? this.multiIndex,
      name: name ?? this.name,
      numberChildren: numberChildren ?? this.numberChildren,
      parentId: parentId ?? this.parentId,
      sequence: sequence ?? this.sequence,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map json) {
  return CategoryModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    sequence: json['sequence'] as int?,
    multiIndex: json['multi_index'] as String?,
    image: json['image'] as String?,
    level: json['level'] as int?,
    parentId: json['parent_id'] as int?,
    numberChildren: json['number_children'] as int?,
  );
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('sequence', instance.sequence);
  writeNotNull('multi_index', instance.multiIndex);
  writeNotNull('parent_id', instance.parentId);
  writeNotNull('image', instance.image);
  writeNotNull('level', instance.level);
  writeNotNull('number_children', instance.numberChildren);
  return val;
}
