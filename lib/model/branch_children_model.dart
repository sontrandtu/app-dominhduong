import 'dart:core';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'branch_children_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class BranchChildrenModel {
  final int? id;
  final String? phone;
  final String? email;
  final String? address;

  BranchChildrenModel({this.id, this.phone, this.email, this.address});

  factory BranchChildrenModel.fromJson(Map<String, dynamic> json) => _$BranchChildrenModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchChildrenModelToJson(this);
}