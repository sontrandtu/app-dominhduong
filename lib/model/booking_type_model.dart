import 'dart:core';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'booking_type_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class BookingTypeModel {
  final int? id;
  final String? name;

  BookingTypeModel({this.id, this.name});

  factory BookingTypeModel.fromJson(Map<String, dynamic> json) => _$BookingTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingTypeModelToJson(this);
}