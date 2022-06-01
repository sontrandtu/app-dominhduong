import 'package:dominhduong/model/video/url_image_video_model.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'thumbnails_video_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class ThumbnailsModel{
  final UrlImageModel? imageDefault;
  final UrlImageModel? medium;
  final UrlImageModel? high;

  ThumbnailsModel({this.imageDefault, this.medium, this.high});

  factory ThumbnailsModel.fromJson(Map<String, dynamic> json) => _$ThumbnailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailsModelToJson(this);
}