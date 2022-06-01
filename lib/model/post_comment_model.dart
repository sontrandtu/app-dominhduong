import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_comment_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class PostCommentModel {
  @JsonKey(name: 'author_name')
  final String? author;
  @JsonKey(name: 'author_email')
  final String? email;
  final String? phone;
  final String? content;
  final int? post;
  final int? parent;
  final String? status;

  PostCommentModel({
    this.author,
    this.email,
    this.content,
    this.phone,
    this.post,
    this.parent,
    this.status
  });

  factory PostCommentModel.fromJson(Map<String?, dynamic> json) =>
      _$PostCommentModelFromJson(json);

  Map<String?, dynamic> toJson() => _$PostCommentModelToJson(this);
}
