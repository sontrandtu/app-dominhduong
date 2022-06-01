import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'examination_card_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class ExaminationCardModel {
  final int? id;
  final String? name;
  final String? detail;
  @JsonKey(name: 'date_start')
  final String? dateStart;
  @JsonKey(name: 'physician_id')
  final int? physicianId;
  @JsonKey(name: 'physician_name')
  final String? physicianName;
  @JsonKey(name: 'order_count')
  final int? orderCount;

  ExaminationCardModel({this.id, this.name, this.detail,this.dateStart, this.physicianId, this.physicianName, this.orderCount});

  factory ExaminationCardModel.fromJson(Map<String?, dynamic> json) => _$ExaminationCardModelFromJson(json);

  Map<String?, dynamic> toJson() => _$ExaminationCardModelToJson(this);
}
