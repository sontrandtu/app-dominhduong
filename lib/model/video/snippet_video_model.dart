import 'package:dominhduong/model/video/thumbnails_video_model.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'snippet_video_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class SnippetVideoModel{
  final String? publishedAt;
  final String? channelId;
  final String? title;
  final String? description;
  final ThumbnailsModel? thumbnails;
  final String? channelTitle;
  final String? liveBroadcastContent;
  final String? publishTime;

  SnippetVideoModel({this.publishedAt, this.channelId, this.title, this.description, this.thumbnails, this.channelTitle, this.liveBroadcastContent, this.publishTime});

  factory SnippetVideoModel.fromJson(Map<String, dynamic> json) => _$SnippetVideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$SnippetVideoModelToJson(this);
}