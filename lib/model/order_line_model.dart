import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_line_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class OrderLineModel {
  final int? id;
  final String? name;
  @JsonKey(name: 'product_uom_qty')
  final int? productUomQty;
  @JsonKey(name: 'price_subtotal')
  final String? priceSubtotal;

  OrderLineModel({this.id, this.name, this.productUomQty, this.priceSubtotal});

  factory OrderLineModel.fromJson(Map<String, dynamic> json) => _$OrderLineModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderLineModelToJson(this);
}
