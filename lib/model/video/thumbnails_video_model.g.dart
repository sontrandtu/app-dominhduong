// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnails_video_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ThumbnailsModelCopyWith on ThumbnailsModel {
  ThumbnailsModel copyWith({
    UrlImageModel? high,
    UrlImageModel? imageDefault,
    UrlImageModel? medium,
  }) {
    return ThumbnailsModel(
      high: high ?? this.high,
      imageDefault: imageDefault ?? this.imageDefault,
      medium: medium ?? this.medium,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThumbnailsModel _$ThumbnailsModelFromJson(Map json) {
  return ThumbnailsModel(
    imageDefault: json['imageDefault'] == null
        ? null
        : UrlImageModel.fromJson(
            Map<String, dynamic>.from(json['imageDefault'] as Map)),
    medium: json['medium'] == null
        ? null
        : UrlImageModel.fromJson(
            Map<String, dynamic>.from(json['medium'] as Map)),
    high: json['high'] == null
        ? null
        : UrlImageModel.fromJson(
            Map<String, dynamic>.from(json['high'] as Map)),
  );
}

Map<String, dynamic> _$ThumbnailsModelToJson(ThumbnailsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('imageDefault', instance.imageDefault);
  writeNotNull('medium', instance.medium);
  writeNotNull('high', instance.high);
  return val;
}
