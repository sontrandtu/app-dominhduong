import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
part 'list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListResponse<T> {
  T? items;
  int? total;
  ListResponse({this.items, this.total});
  factory ListResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT,) => _$ListResponseFromJson(json, fromJsonT);
}
