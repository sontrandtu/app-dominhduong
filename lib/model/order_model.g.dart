// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension OrderModelCopyWith on OrderModel {
  OrderModel copyWith({
    String? amountTotal,
    String? dateOrder,
    int? id,
    String? name,
    List<OrderLineModel>? orderLines,
    int? productNumber,
    String? state,
  }) {
    return OrderModel(
      amountTotal: amountTotal ?? this.amountTotal,
      dateOrder: dateOrder ?? this.dateOrder,
      id: id ?? this.id,
      name: name ?? this.name,
      orderLines: orderLines ?? this.orderLines,
      productNumber: productNumber ?? this.productNumber,
      state: state ?? this.state,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map json) {
  return OrderModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    state: json['state'] as String?,
    amountTotal: json['amount_total'] as String?,
    dateOrder: json['date_order'] as String?,
    productNumber: json['product_number'] as int?,
    orderLines: (json['order_lines'] as List<dynamic>?)
        ?.map(
            (e) => OrderLineModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('state', instance.state);
  writeNotNull('amount_total', instance.amountTotal);
  writeNotNull('date_order', instance.dateOrder);
  writeNotNull('product_number', instance.productNumber);
  writeNotNull('order_lines', instance.orderLines);
  return val;
}
