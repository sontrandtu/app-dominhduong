import 'dart:core';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:dominhduong/model/order_line_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'order_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class OrderModel {
  final int? id;
  final String? name;
  final String? state;
  @JsonKey(name: 'amount_total')
  final String? amountTotal;
  @JsonKey(name: 'date_order')
  final String? dateOrder;
  @JsonKey(name: 'product_number')
  final int? productNumber;
  @JsonKey(name: 'order_lines')
  final List<OrderLineModel>? orderLines;

  OrderModel({this.id, this.name, this.state, this.amountTotal, this.dateOrder, this.productNumber, this.orderLines});

  factory OrderModel.fromJson(Map<String?, dynamic> json) => _$OrderModelFromJson(json);

  Map<String?, dynamic> toJson() => _$OrderModelToJson(this);
}
