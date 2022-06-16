import 'dart:core';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:dominhduong/model/article_model.dart';
import 'package:dominhduong/model/category_model.dart';
import 'package:dominhduong/model/doctor_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../app_config.dart';

part 'widget_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class WidgetModel {
  final int? id;
  final String? type;
  final String? name;
  final String? code;
  final String? description;
  final String? content;
  final String? image;
  @JsonKey(name: 'category_id')
  final int? categoryId;
  final List<String>? images;
  final List<CategoryModel>? categories;
  final List<DoctorModel>? doctors;
  final List<ArticleModel>? articles;

  String get imageUrl {
    return image != null ? AppConfig.prefixUrl + image! : '';
  }

  List<String> get arrImageUrl {
    List<String> data = [];
    if ((images ?? []).isNotEmpty) {
      for (var image in images!) {
        if(image.isNotEmpty) data.add(AppConfig.prefixUrl + image);
      }
    }
    return data;
  }

  WidgetModel({this.id, this.type, this.name, this.code, this.description, this.content, this.image, this.categoryId, this.images, this.categories, this.doctors, this.articles});

  factory WidgetModel.fromJson(Map<String?, dynamic> json) => _$WidgetModelFromJson(json);

  Map<String?, dynamic> toJson() => _$WidgetModelToJson(this);
}
