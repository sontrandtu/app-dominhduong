// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension BranchModelCopyWith on BranchModel {
  BranchModel copyWith({
    List<BranchChildrenModel>? children,
    int? id,
    String? name,
  }) {
    return BranchModel(
      children: children ?? this.children,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map json) {
  return BranchModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    children: (json['children'] as List<dynamic>?)
        ?.map((e) =>
            BranchChildrenModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  )..isSelected = json['isSelected'] as bool?;
}

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('children', instance.children);
  writeNotNull('isSelected', instance.isSelected);
  return val;
}
