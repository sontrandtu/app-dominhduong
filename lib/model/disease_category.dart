import 'dart:core';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'disease_category.g.dart';
@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class DiseaseCategory {
 final int? id;
 final String? name;
 final int? sequence;
 final String? multiIndex;
 final String? image;
 final List<String>? parentId;
 final int? level;

  DiseaseCategory(
      {this.id,
        this.name,
        this.sequence,
        this.multiIndex,
        this.image,
        this.parentId,
        this.level});

  factory DiseaseCategory.fromJson(Map<String, dynamic> json) =>
      _$DiseaseCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$DiseaseCategoryToJson(this);
}
