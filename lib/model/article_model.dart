import 'dart:core';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:dominhduong/app_config.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class ArticleModel {
  final int? id;
  final String? name;
  final String? image;
  final String? description;
  final String? content;
  final double? rating;
  @JsonKey(name: 'create_image')
  final String? createImage;
  @JsonKey(name: 'create_date')
  final String? createDate;
  @JsonKey(name: 'create_name')
  final String? createName;
  @JsonKey(name: 'category_id')
  final int? categoryId;

  ArticleModel({
    this.id,
    this.name,
    this.image,
    this.description,
    this.content,
    this.rating,
    this.createImage,
    this.createDate,
    this.createName,
    this.categoryId
  });

  String get imageUrl {
    return image != null ? AppConfig.prefixUrl + image! : '';
  }

  String get partnerImageUrl {
    return createImage != null ? AppConfig.prefixUrl + createImage! : '';
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
