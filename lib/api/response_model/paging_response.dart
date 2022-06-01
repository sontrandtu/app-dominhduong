import 'package:dominhduong/api/response_model/pagination.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paging_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PagingResponse<T> {
  final T? entries;
  final Pagination? pagination;

  PagingResponse({this.entries, this.pagination});

  factory PagingResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PagingResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PagingResponseToJson(this, toJsonT);
}
