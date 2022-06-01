
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'id_item_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class IdItemsModel{
  final String? kind;
  final String? channelId;
  final String? videoId;

  IdItemsModel({this.kind, this.channelId, this.videoId});

  factory IdItemsModel.fromJson(Map<String, dynamic> json) => _$IdItemsModelFromJson(json);

  Map<String, dynamic> toJson() => _$IdItemsModelToJson(this);
}