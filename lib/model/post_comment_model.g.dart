// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension PostCommentModelCopyWith on PostCommentModel {
  PostCommentModel copyWith({
    String? author,
    String? content,
    String? email,
    int? parent,
    String? phone,
    int? post,
    String? status,
  }) {
    return PostCommentModel(
      author: author ?? this.author,
      content: content ?? this.content,
      email: email ?? this.email,
      parent: parent ?? this.parent,
      phone: phone ?? this.phone,
      post: post ?? this.post,
      status: status ?? this.status,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCommentModel _$PostCommentModelFromJson(Map json) {
  return PostCommentModel(
    author: json['author_name'] as String?,
    email: json['author_email'] as String?,
    content: json['content'] as String?,
    phone: json['phone'] as String?,
    post: json['post'] as int?,
    parent: json['parent'] as int?,
    status: json['status'] as String?,
  );
}

Map<String, dynamic> _$PostCommentModelToJson(PostCommentModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('author_name', instance.author);
  writeNotNull('author_email', instance.email);
  writeNotNull('phone', instance.phone);
  writeNotNull('content', instance.content);
  writeNotNull('post', instance.post);
  writeNotNull('parent', instance.parent);
  writeNotNull('status', instance.status);
  return val;
}
