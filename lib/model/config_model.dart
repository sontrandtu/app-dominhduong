// To parse this JSON data, do
//
//     final configModel = configModelFromJson(jsonString);

import 'dart:convert';

ConfigModel configModelFromJson(String str) => ConfigModel.fromJson(json.decode(str));

String configModelToJson(ConfigModel data) => json.encode(data.toJson());

class ConfigModel {
  ConfigModel({
    this.linkZalo,
    this.writeDate,
    this.linkMessage,
  });

  String? linkZalo;
  String? writeDate;
  String? linkMessage;

  factory ConfigModel.fromJson(Map<String, dynamic> json) => ConfigModel(
    linkZalo: json["link_zalo"],
    writeDate: json["write_date"],
    linkMessage: json["link_message"],
  );

  Map<String, dynamic> toJson() => {
    "link_zalo": linkZalo,
    "write_date": writeDate,
    "link_message": linkMessage,
  };
}
