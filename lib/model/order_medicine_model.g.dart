// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_medicine_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension OrderMedicineModelCopyWith on OrderMedicineModel {
  OrderMedicineModel copyWith({
    String? address,
    int? categoryId,
    String? categoryName,
    String? dateOrder,
    String? deliveryNote,
    String? districtName,
    int? id,
    bool? isHavePrescription,
    String? note,
    String? partnerName,
    String? paymentType,
    String? prescriptionImage,
    String? provinceName,
    int? quantity,
    String? receiverName,
    String? receiverPhone,
    String? state,
    String? wardName,
  }) {
    return OrderMedicineModel(
      address: address ?? this.address,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      dateOrder: dateOrder ?? this.dateOrder,
      deliveryNote: deliveryNote ?? this.deliveryNote,
      districtName: districtName ?? this.districtName,
      id: id ?? this.id,
      isHavePrescription: isHavePrescription ?? this.isHavePrescription,
      note: note ?? this.note,
      partnerName: partnerName ?? this.partnerName,
      paymentType: paymentType ?? this.paymentType,
      prescriptionImage: prescriptionImage ?? this.prescriptionImage,
      provinceName: provinceName ?? this.provinceName,
      quantity: quantity ?? this.quantity,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      state: state ?? this.state,
      wardName: wardName ?? this.wardName,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderMedicineModel _$OrderMedicineModelFromJson(Map json) {
  return OrderMedicineModel(
    id: json['id'] as int?,
    state: json['state'] as String?,
    categoryId: json['category_id'] as int?,
    categoryName: json['category_name'] as String?,
    quantity: json['quantity'] as int?,
    isHavePrescription: json['is_have_prescription'] as bool?,
    prescriptionImage: json['prescription_image'] as String?,
    partnerName: json['partner_name'] as String?,
    dateOrder: json['date_order'] as String?,
    receiverName: json['receiver_name'] as String?,
    receiverPhone: json['receiver_phone'] as String?,
    paymentType: json['payment_type'] as String?,
    deliveryNote: json['delivery_note'] as String?,
    provinceName: json['province_name'] as String?,
    districtName: json['district_name'] as String?,
    wardName: json['ward_name'] as String?,
    address: json['address'] as String?,
    note: json['note'] as String?,
  )
    ..provinceId = json['province_id'] as int?
    ..districtId = json['district_id'] as int?
    ..wardId = json['ward_id'] as int?;
}

Map<String, dynamic> _$OrderMedicineModelToJson(OrderMedicineModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('state', instance.state);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('category_name', instance.categoryName);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('is_have_prescription', instance.isHavePrescription);
  writeNotNull('prescription_image', instance.prescriptionImage);
  writeNotNull('partner_name', instance.partnerName);
  writeNotNull('date_order', instance.dateOrder);
  writeNotNull('receiver_name', instance.receiverName);
  writeNotNull('receiver_phone', instance.receiverPhone);
  writeNotNull('payment_type', instance.paymentType);
  writeNotNull('delivery_note', instance.deliveryNote);
  writeNotNull('province_name', instance.provinceName);
  writeNotNull('province_id', instance.provinceId);
  writeNotNull('district_name', instance.districtName);
  writeNotNull('district_id', instance.districtId);
  writeNotNull('ward_name', instance.wardName);
  writeNotNull('ward_id', instance.wardId);
  writeNotNull('address', instance.address);
  writeNotNull('note', instance.note);
  return val;
}
