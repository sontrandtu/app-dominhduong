// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension WidgetModelCopyWith on WidgetModel {
  WidgetModel copyWith({
    List<ArticleModel>? articles,
    List<CategoryModel>? categories,
    int? categoryId,
    String? code,
    String? content,
    String? description,
    List<DoctorModel>? doctors,
    int? id,
    String? image,
    List<String>? images,
    String? name,
    String? type,
  }) {
    return WidgetModel(
      articles: articles ?? this.articles,
      categories: categories ?? this.categories,
      categoryId: categoryId ?? this.categoryId,
      code: code ?? this.code,
      content: content ?? this.content,
      description: description ?? this.description,
      doctors: doctors ?? this.doctors,
      id: id ?? this.id,
      image: image ?? this.image,
      images: images ?? this.images,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WidgetModel _$WidgetModelFromJson(Map json) {
  return WidgetModel(
    id: json['id'] as int?,
    type: json['type'] as String?,
    name: json['name'] as String?,
    code: json['code'] as String?,
    description: json['description'] as String?,
    content: json['content'] as String?,
    image: json['image'] as String?,
    categoryId: json['category_id'] as int?,
    images:
        (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    categories: (json['categories'] as List<dynamic>?)
        ?.map(
            (e) => CategoryModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
    doctors: (json['doctors'] as List<dynamic>?)
        ?.map((e) => DoctorModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
    articles: (json['articles'] as List<dynamic>?)
        ?.map((e) => ArticleModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
  );
}

Map<String, dynamic> _$WidgetModelToJson(WidgetModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('type', instance.type);
  writeNotNull('name', instance.name);
  writeNotNull('code', instance.code);
  writeNotNull('description', instance.description);
  writeNotNull('content', instance.content);
  writeNotNull('image', instance.image);
  writeNotNull('category_id', instance.categoryId);
  writeNotNull('images', instance.images);
  writeNotNull('categories', instance.categories);
  writeNotNull('doctors', instance.doctors);
  writeNotNull('articles', instance.articles);
  return val;
}
