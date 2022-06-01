import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import '../app_config.dart';
part 'order_medicine_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class OrderMedicineModel {
  int? id;
  String? state;
  @JsonKey(name: 'category_id')
  int? categoryId;
  @JsonKey(name: 'category_name')
  String? categoryName;
  int? quantity;
  @JsonKey(name: 'is_have_prescription')
  bool? isHavePrescription;
  @JsonKey(name: 'prescription_image')
  String? prescriptionImage;
  @JsonKey(name: 'partner_name')
  String? partnerName;
  @JsonKey(name: 'date_order')
  String? dateOrder;
  @JsonKey(name: 'receiver_name')
  String? receiverName;
  @JsonKey(name: 'receiver_phone')
  String? receiverPhone;
  @JsonKey(name: 'payment_type')
  String? paymentType;
  @JsonKey(name: 'delivery_note')
  String? deliveryNote;
  @JsonKey(name: 'province_name')
  String? provinceName;
  @JsonKey(name: 'province_id')
  int? provinceId;
  @JsonKey(name: 'district_name')
  String? districtName;
  @JsonKey(name: 'district_id')
  int? districtId;
  @JsonKey(name: 'ward_name')
  String? wardName;
  @JsonKey(name: 'ward_id')
  int? wardId;
  String? address;
  String? note;

  OrderMedicineModel({
    this.id,
    this.state,
    this.categoryId,
    this.categoryName,
    this.quantity,
    this.isHavePrescription,
    this.prescriptionImage,
    this.partnerName,
    this.dateOrder,
    this.receiverName,
    this.receiverPhone,
    this.paymentType,
    this.deliveryNote,
    this.provinceName,
    this.districtName,
    this.wardName,
    this.address,
    this.note,
  });

  String get imageUrl {
    return prescriptionImage != null ? AppConfig.prefixUrl + prescriptionImage! : '';
  }

  factory OrderMedicineModel.fromJson(Map<String?, dynamic> json) => _$OrderMedicineModelFromJson(json);

  Map<String?, dynamic> toJson() => _$OrderMedicineModelToJson(this);
}
