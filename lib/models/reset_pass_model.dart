/// message : "Password updated successfully"

class ResetPassModel {
  ResetPassModel({
    this.statusCode,
    this.message,
  });

  ResetPassModel.fromJson(dynamic json) {
    if (json["message"] is String) {
      message = json["message"];
    } else {
      message = json['message'] != null ? json['message'].cast<String>() : [];
    }
    statusCode = json['statusCode'];
  }

  var message;
  int? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['statusCode'] = statusCode;
    return map;
  }
}
