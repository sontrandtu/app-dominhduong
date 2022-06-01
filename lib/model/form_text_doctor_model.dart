import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'form_text_doctor_model.g.dart';

@CopyWith(generateCopyWithNull: false)
@JsonSerializable(anyMap: true, includeIfNull: false)
class FormTextDoctorModel{
  String? userName;
  String? numberPhone;
  String? email;
  String? reason;

  FormTextDoctorModel({this.userName, this.numberPhone, this.email, this.reason});

  factory FormTextDoctorModel.fromJson(Map<String, dynamic> json) => _$FormTextDoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormTextDoctorModelToJson(this);
}