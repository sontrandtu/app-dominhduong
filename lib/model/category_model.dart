import 'dart:core';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import '../app_config.dart';
part 'category_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class CategoryModel {
  final int? id;
  final String? name;
  final int? sequence;
  @JsonKey(name: 'multi_index')
  final String? multiIndex;
  @JsonKey(name: 'parent_id')
  final int? parentId;
  final String? image;
  final int? level;
  @JsonKey(name: 'number_children')
  final int? numberChildren;
  @JsonKey(ignore: true)
  bool isSelected;

  CategoryModel({
    this.id,
    this.name,
    this.sequence,
    this.multiIndex,
    this.image,
    this.level,
    this.parentId,
    this.numberChildren,
    this.isSelected = false,
  });

  String get imageUrl{
    return image != null ? AppConfig.prefixUrl + image! : '';
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
