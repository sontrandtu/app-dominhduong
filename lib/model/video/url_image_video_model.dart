import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'url_image_video_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class UrlImageModel{
  final String? url;

  UrlImageModel({this.url});

  factory UrlImageModel.fromJson(Map<String, dynamic> json) => _$UrlImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$UrlImageModelToJson(this);
}