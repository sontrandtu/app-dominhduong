// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension CompanyModelCopyWith on CompanyModel {
  CompanyModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? street,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      street: street ?? this.street,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map json) {
  return CompanyModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    street: json['street'] as String?,
    phone: json['phone'] as String?,
  );
}

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('street', instance.street);
  writeNotNull('phone', instance.phone);
  return val;
}
