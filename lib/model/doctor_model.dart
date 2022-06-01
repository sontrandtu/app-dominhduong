import 'dart:core';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import '../app_config.dart';

part 'doctor_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class DoctorModel {
  final int? id;
  final int? sequence;
  final String? name;
  final String? position;
  final String? image;
  final String? description;
  final String? content;
  @JsonKey(name: 'branch_id')
  final int? branchId;
  @JsonKey(name: 'physician_id')
  final int? physicianId;
  @JsonKey(name: 'write_date')
  final String? writeDate;
  bool? isSelected = false;

  DoctorModel({this.id, this.sequence, this.name, this.position, this.image, this.description, this.content, this.branchId, this.physicianId, this.writeDate});

  String get imageUrl {
    return image != null ? AppConfig.prefixUrl + image! : '';
  }

  String? get splitName {
    if (name?.toLowerCase().contains('bác sĩ') ?? false) {
      return 'Bác sĩ \n ${name?.replaceAll('Bác sĩ', '')}';
    } else if (name?.toLowerCase().contains('lương y') ?? false) {
      return 'Lương Y \n ${name?.replaceAll('Lương y', '')}';
    } else {
      return name;
    }
  }

  factory DoctorModel.fromJson(Map<String, dynamic> json) => _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);
}
