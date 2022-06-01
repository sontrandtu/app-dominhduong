// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ContentModelCopyWith on ContentModel {
  ContentModel copyWith({
    String? rendered,
  }) {
    return ContentModel(
      rendered: rendered ?? this.rendered,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentModel _$ContentModelFromJson(Map json) {
  return ContentModel(
    rendered: json['rendered'] as String?,
  );
}

Map<String, dynamic> _$ContentModelToJson(ContentModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rendered', instance.rendered);
  return val;
}
