// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_text_doctor_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension FormTextDoctorModelCopyWith on FormTextDoctorModel {
  FormTextDoctorModel copyWith({
    String? email,
    String? numberPhone,
    String? reason,
    String? userName,
  }) {
    return FormTextDoctorModel(
      email: email ?? this.email,
      numberPhone: numberPhone ?? this.numberPhone,
      reason: reason ?? this.reason,
      userName: userName ?? this.userName,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormTextDoctorModel _$FormTextDoctorModelFromJson(Map json) {
  return FormTextDoctorModel(
    userName: json['userName'] as String?,
    numberPhone: json['numberPhone'] as String?,
    email: json['email'] as String?,
    reason: json['reason'] as String?,
  );
}

Map<String, dynamic> _$FormTextDoctorModelToJson(FormTextDoctorModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('userName', instance.userName);
  writeNotNull('numberPhone', instance.numberPhone);
  writeNotNull('email', instance.email);
  writeNotNull('reason', instance.reason);
  return val;
}
