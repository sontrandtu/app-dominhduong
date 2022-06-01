// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_children_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension BranchChildrenModelCopyWith on BranchChildrenModel {
  BranchChildrenModel copyWith({
    String? address,
    String? email,
    int? id,
    String? phone,
  }) {
    return BranchChildrenModel(
      address: address ?? this.address,
      email: email ?? this.email,
      id: id ?? this.id,
      phone: phone ?? this.phone,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchChildrenModel _$BranchChildrenModelFromJson(Map json) {
  return BranchChildrenModel(
    id: json['id'] as int?,
    phone: json['phone'] as String?,
    email: json['email'] as String?,
    address: json['address'] as String?,
  );
}

Map<String, dynamic> _$BranchChildrenModelToJson(BranchChildrenModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('phone', instance.phone);
  writeNotNull('email', instance.email);
  writeNotNull('address', instance.address);
  return val;
}
