// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_line_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension OrderLineModelCopyWith on OrderLineModel {
  OrderLineModel copyWith({
    int? id,
    String? name,
    String? priceSubtotal,
    int? productUomQty,
  }) {
    return OrderLineModel(
      id: id ?? this.id,
      name: name ?? this.name,
      priceSubtotal: priceSubtotal ?? this.priceSubtotal,
      productUomQty: productUomQty ?? this.productUomQty,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderLineModel _$OrderLineModelFromJson(Map json) {
  return OrderLineModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    productUomQty: json['product_uom_qty'] as int?,
    priceSubtotal: json['price_subtotal'] as String?,
  );
}

Map<String, dynamic> _$OrderLineModelToJson(OrderLineModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('product_uom_qty', instance.productUomQty);
  writeNotNull('price_subtotal', instance.priceSubtotal);
  return val;
}
