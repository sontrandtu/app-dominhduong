
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'history_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class HistoryModel {
  final int id;
  final String? name;
  @JsonKey(name: 'appointment_type')
  final String? appointmentType;
  @JsonKey(name: 'partner_id')
  final int partnerId;
  final String? phone;
  @JsonKey(name: 'partner_address')
  final String? partnerAddress;
  @JsonKey(name: 'date_start')
  final String? dateStart;
  @JsonKey(name: 'time_slot_name')
  final String? timeSlotName;
  @JsonKey(name: 'physician_name')
  final String? physicianName;
  @JsonKey(name: 'branch_name')
  final String? branchName;
  @JsonKey(name: 'type_name')
  final String? typeName;
  final String? reason;
  final String state;

  HistoryModel({
    required this.id,
    this.name,
    this.appointmentType,
    required this.partnerId,
    this.phone,
    this.partnerAddress,
    this.dateStart,
    this.timeSlotName,
    this.physicianName,
    this.typeName,
    this.reason,
    this.branchName,
    required this.state,
  });


  factory HistoryModel.fromJson(Map<String, dynamic> json) => _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
