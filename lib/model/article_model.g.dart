// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ArticleModelCopyWith on ArticleModel {
  ArticleModel copyWith({
    int? categoryId,
    String? content,
    String? createDate,
    String? createImage,
    String? createName,
    String? description,
    int? id,
    String? image,
    String? name,
    double? rating,
  }) {
    return ArticleModel(
      categoryId: categoryId ?? this.categoryId,
      content: content ?? this.content,
      createDate: createDate ?? this.createDate,
      createImage: createImage ?? this.createImage,
      createName: createName ?? this.createName,
      description: description ?? this.description,
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      rating: rating ?? this.rating,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map json) {
  return ArticleModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    image: json['image'] as String?,
    description: json['description'] as String?,
    content: json['content'] as String?,
    rating: (json['rating'] as num?)?.toDouble(),
    createImage: json['create_image'] as String?,
    createDate: json['create_date'] as String?,
    createName: json['create_name'] as String?,
    categoryId: json['category_id'] as int?,
  );
}

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('image', instance.image);
  writeNotNull('description', instance.description);
  writeNotNull('content', instance.content);
  writeNotNull('rating', instance.rating);
  writeNotNull('create_image', instance.createImage);
  writeNotNull('create_date', instance.createDate);
  writeNotNull('create_name', instance.createName);
  writeNotNull('category_id', instance.categoryId);
  return val;
}
