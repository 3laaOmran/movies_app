/// message : "Invalid or expired token"
/// error : "Unauthorized"
/// statusCode : 401

class UpdateOrDeleteProfileModel {
  UpdateOrDeleteProfileModel({
    this.message,
    this.error,
    this.statusCode,
  });

  UpdateOrDeleteProfileModel.fromJson(dynamic json) {
    message = json['message'];
    error = json['error'];
    statusCode = json['statusCode'];
  }

  String? message;
  String? error;
  int? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['error'] = error;
    map['statusCode'] = statusCode;
    return map;
  }
}
