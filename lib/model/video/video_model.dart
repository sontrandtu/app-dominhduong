import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:dominhduong/model/video/id_item_model.dart';
import 'package:dominhduong/model/video/snippet_video_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'video_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class VideoModel{
  final String? kind;
  final String? etag;
  @JsonKey(name: "id")
  final IdItemsModel? idVideoModel;
  final SnippetVideoModel? snippet;

  VideoModel({this.kind, this.etag, this.idVideoModel, this.snippet, });

  factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}