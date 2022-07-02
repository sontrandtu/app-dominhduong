import 'dart:core';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:dominhduong/app_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class UserInfoModel {
  final int? id;
  @JsonKey(name: 'province_id')
  late int? provinceId;
  @JsonKey(name: 'district_id')
  late int? districtId;
  @JsonKey(name: 'ward_id')
  late int? wardId;
  @JsonKey(name: 'province_name')
  late String? provinceName;
  @JsonKey(name: 'district_name')
  late String? districtName;
  @JsonKey(name: 'ward_name')
  late String? wardName;
  late String? name;
  late String? phone;
  late String? mobile;
  final String? token;
  late String? image;
  late String? birthday;
  late String? street;
  late String? email;
  @JsonKey(name: 'x_gender')
  late String? gender;
  @JsonKey(name: 'topic_ids')
  late List<int>? topicIds;
  @JsonKey(name: 'topic_of_interest_ids')
  late List<int>? topicOfInterestIds;

  UserInfoModel({
    this.email,
    this.id,
    this.provinceId,
    this.districtId,
    this.wardId,
    this.provinceName,
    this.districtName,
    this.wardName,
    this.name,
    this.phone,
    this.mobile,
    this.token,
    this.image,
    this.birthday,
    this.street,
    this.gender,
    this.topicIds,
    this.topicOfInterestIds
  });

  String get imageUrl {
    return image != null ? AppConfig.prefixUrl + image! : '';
  }

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
