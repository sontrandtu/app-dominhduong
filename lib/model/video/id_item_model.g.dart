// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_item_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension IdItemsModelCopyWith on IdItemsModel {
  IdItemsModel copyWith({
    String? channelId,
    String? kind,
    String? videoId,
  }) {
    return IdItemsModel(
      channelId: channelId ?? this.channelId,
      kind: kind ?? this.kind,
      videoId: videoId ?? this.videoId,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdItemsModel _$IdItemsModelFromJson(Map json) {
  return IdItemsModel(
    kind: json['kind'] as String?,
    channelId: json['channelId'] as String?,
    videoId: json['videoId'] as String?,
  );
}

Map<String, dynamic> _$IdItemsModelToJson(IdItemsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('kind', instance.kind);
  writeNotNull('channelId', instance.channelId);
  writeNotNull('videoId', instance.videoId);
  return val;
}
