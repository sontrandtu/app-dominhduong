// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_image_video_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension UrlImageModelCopyWith on UrlImageModel {
  UrlImageModel copyWith({
    String? url,
  }) {
    return UrlImageModel(
      url: url ?? this.url,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UrlImageModel _$UrlImageModelFromJson(Map json) {
  return UrlImageModel(
    url: json['url'] as String?,
  );
}

Map<String, dynamic> _$UrlImageModelToJson(UrlImageModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  return val;
}
