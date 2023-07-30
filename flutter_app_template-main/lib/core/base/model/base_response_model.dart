import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
part 'base_response_model.g.dart';

@JsonSerializable()
class BaseResponseModel extends INetworkModel<BaseResponseModel> {
  final bool? type;
  final String? message;
  dynamic data;
  final BaseErrorResponseModel? error;

  BaseResponseModel({this.type, this.message, this.data, this.error});

  @override
  BaseResponseModel fromJson(Map<String, dynamic> json) {
    return _$BaseResponseModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$BaseResponseModelToJson(this);
  }
}


@JsonSerializable()
class BaseErrorResponseModel extends INetworkModel<BaseErrorResponseModel> {
  BaseErrorResponseModel({
    this.statusCode,
    this.description,
  });
  final int? statusCode;
  final String? description;
  
  @override
  BaseErrorResponseModel fromJson(Map<String, dynamic> json) {
    return _$BaseErrorResponseModelFromJson(json);
  }


  factory BaseErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return _$BaseErrorResponseModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$BaseErrorResponseModelToJson(this);
  }
}
