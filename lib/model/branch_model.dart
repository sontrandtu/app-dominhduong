import 'dart:core';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'branch_children_model.dart';
part 'branch_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class BranchModel {
  final int? id;
  final String? name;
  final List<BranchChildrenModel>? children;
  bool? isSelected = false;

  BranchModel({this.id, this.name, this.children});

  factory BranchModel.fromJson(Map<String, dynamic> json) => _$BranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
}