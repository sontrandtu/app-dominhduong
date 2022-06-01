// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UserInfoModelCopyWith on UserInfoModel {
  UserInfoModel copyWith({
    String? birthday,
    int? districtId,
    String? districtName,
    String? email,
    String? gender,
    int? id,
    String? image,
    String? mobile,
    String? name,
    String? phone,
    int? provinceId,
    String? provinceName,
    String? street,
    String? token,
    List<int>? topicIds,
    List<int>? topicOfInterestIds,
    int? wardId,
    String? wardName,
  }) {
    return UserInfoModel(
      birthday: birthday ?? this.birthday,
      districtId: districtId ?? this.districtId,
      districtName: districtName ?? this.districtName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      image: image ?? this.image,
      mobile: mobile ?? this.mobile,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      provinceId: provinceId ?? this.provinceId,
      provinceName: provinceName ?? this.provinceName,
      street: street ?? this.street,
      token: token ?? this.token,
      topicIds: topicIds ?? this.topicIds,
      topicOfInterestIds: topicOfInterestIds ?? this.topicOfInterestIds,
      wardId: wardId ?? this.wardId,
      wardName: wardName ?? this.wardName,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map json) {
  return UserInfoModel(
    email: json['email'] as String?,
    id: json['id'] as int?,
    provinceId: json['province_id'] as int?,
    districtId: json['district_id'] as int?,
    wardId: json['ward_id'] as int?,
    provinceName: json['province_name'] as String?,
    districtName: json['district_name'] as String?,
    wardName: json['ward_name'] as String?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    mobile: json['mobile'] as String?,
    token: json['token'] as String?,
    image: json['image'] as String?,
    birthday: json['birthday'] as String?,
    street: json['street'] as String?,
    gender: json['x_gender'] as String?,
    topicIds:
        (json['topic_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
    topicOfInterestIds: (json['topic_of_interest_ids'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList(),
  );
}

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('province_id', instance.provinceId);
  writeNotNull('district_id', instance.districtId);
  writeNotNull('ward_id', instance.wardId);
  writeNotNull('province_name', instance.provinceName);
  writeNotNull('district_name', instance.districtName);
  writeNotNull('ward_name', instance.wardName);
  writeNotNull('name', instance.name);
  writeNotNull('phone', instance.phone);
  writeNotNull('mobile', instance.mobile);
  writeNotNull('token', instance.token);
  writeNotNull('image', instance.image);
  writeNotNull('birthday', instance.birthday);
  writeNotNull('street', instance.street);
  writeNotNull('email', instance.email);
  writeNotNull('x_gender', instance.gender);
  writeNotNull('topic_ids', instance.topicIds);
  writeNotNull('topic_of_interest_ids', instance.topicOfInterestIds);
  return val;
}
