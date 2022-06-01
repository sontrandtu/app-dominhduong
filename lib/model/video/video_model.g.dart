// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension VideoModelCopyWith on VideoModel {
  VideoModel copyWith({
    String? etag,
    IdItemsModel? idVideoModel,
    String? kind,
    SnippetVideoModel? snippet,
  }) {
    return VideoModel(
      etag: etag ?? this.etag,
      idVideoModel: idVideoModel ?? this.idVideoModel,
      kind: kind ?? this.kind,
      snippet: snippet ?? this.snippet,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map json) {
  return VideoModel(
    kind: json['kind'] as String?,
    etag: json['etag'] as String?,
    idVideoModel: json['id'] == null
        ? null
        : IdItemsModel.fromJson(Map<String, dynamic>.from(json['id'] as Map)),
    snippet: json['snippet'] == null
        ? null
        : SnippetVideoModel.fromJson(
            Map<String, dynamic>.from(json['snippet'] as Map)),
  );
}

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('kind', instance.kind);
  writeNotNull('etag', instance.etag);
  writeNotNull('id', instance.idVideoModel);
  writeNotNull('snippet', instance.snippet);
  return val;
}
