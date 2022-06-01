import 'dart:core';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timeslot_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class TimeSlotModel {
  final int? id;
  final String? name;
  @JsonKey(name: 'time_start')
  final String? timeStart;
  @JsonKey(name: 'time_end')
  final String? timeEnd;

  TimeSlotModel({this.id, this.name, this.timeStart, this.timeEnd});

  bool get isSelected{
    double currentTime = DateTime.now().hour * 1.0 +DateTime.now().minute/60;
    double inputTime = double.parse(timeStart?.split(':')[0] ?? '') + double.parse(timeStart?.split(':')[1] ?? '')/60;
    if(currentTime < inputTime){
      return true;
    }
    return false;
  }

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => _$TimeSlotModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotModelToJson(this);
}
