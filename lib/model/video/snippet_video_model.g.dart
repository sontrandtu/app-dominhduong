// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet_video_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension SnippetVideoModelCopyWith on SnippetVideoModel {
  SnippetVideoModel copyWith({
    String? channelId,
    String? channelTitle,
    String? description,
    String? liveBroadcastContent,
    String? publishTime,
    String? publishedAt,
    ThumbnailsModel? thumbnails,
    String? title,
  }) {
    return SnippetVideoModel(
      channelId: channelId ?? this.channelId,
      channelTitle: channelTitle ?? this.channelTitle,
      description: description ?? this.description,
      liveBroadcastContent: liveBroadcastContent ?? this.liveBroadcastContent,
      publishTime: publishTime ?? this.publishTime,
      publishedAt: publishedAt ?? this.publishedAt,
      thumbnails: thumbnails ?? this.thumbnails,
      title: title ?? this.title,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnippetVideoModel _$SnippetVideoModelFromJson(Map json) {
  return SnippetVideoModel(
    publishedAt: json['publishedAt'] as String?,
    channelId: json['channelId'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    thumbnails: json['thumbnails'] == null
        ? null
        : ThumbnailsModel.fromJson(
            Map<String, dynamic>.from(json['thumbnails'] as Map)),
    channelTitle: json['channelTitle'] as String?,
    liveBroadcastContent: json['liveBroadcastContent'] as String?,
    publishTime: json['publishTime'] as String?,
  );
}

Map<String, dynamic> _$SnippetVideoModelToJson(SnippetVideoModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('publishedAt', instance.publishedAt);
  writeNotNull('channelId', instance.channelId);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('thumbnails', instance.thumbnails);
  writeNotNull('channelTitle', instance.channelTitle);
  writeNotNull('liveBroadcastContent', instance.liveBroadcastContent);
  writeNotNull('publishTime', instance.publishTime);
  return val;
}
